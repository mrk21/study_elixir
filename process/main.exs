IO.puts "## Base"
send self(), {:hello, "world"}

IO.inspect(receive do
  {:hello, msg} -> msg
  {:world, _} -> "won't match"
end)
IO.puts ""


IO.puts "## Config Process"
defmodule KV do
  def start_link do
    {:ok, spawn_link(fn -> loop(%{}) end)}
  end
  
  defp loop(map) do
    receive do
      {:get, key, caller} ->
        send caller, Map.get(map, key)
        loop(map)
      {:put, key, value} ->
        loop(Map.put(map, key, value))
    end
  end
end

IO.inspect {:ok, pid} = KV.start_link
IO.inspect send pid, {:put, :hello, :world}
IO.inspect send pid, {:get, :hello, self()}

receive do
  value -> IO.inspect value
end
IO.puts ""


IO.puts "## OTP: GenServer"
defmodule KV2 do
  use GenServer
  
  def start_link do
    GenServer.start_link(__MODULE__, %{})
  end
  
  def get(pid, key) do
    GenServer.call(pid, {:get, key})
  end
  
  def put(pid, key, value) do
    GenServer.call(pid, {:put, key, value})
  end
  
  def handle_call({:get, key}, _from, state) do
    {:reply, Map.get(state, key), state}
  end
  
  def handle_call({:put, key, value}, _from, state) do
    {:reply, value, Map.put(state, key, value)}
  end
end
IO.inspect {:ok, pid} = KV2.start_link
IO.inspect KV2.get(pid, :a)
IO.inspect KV2.put(pid, :a, 1)
IO.inspect KV2.get(pid, :a)
IO.puts ""


IO.puts "## OTP: Agent"
defmodule KV3 do
  def start_link do
    Agent.start_link fn -> %{} end
  end
  
  def get(pid, key) do
    Agent.get pid, fn (map) -> Map.get(map, key) end
  end
  
  def put(pid, key, value) do
    Agent.update pid, fn (map) -> Map.put(map, key, value) end
  end
end

IO.inspect {:ok, pid} = KV3.start_link
IO.inspect KV3.get(pid, :a)
IO.inspect KV3.put(pid, :a, 1)
IO.inspect KV3.get(pid, :a)
IO.puts ""


IO.puts "## OTP: Task"
defmodule TaskModule do
  def parallel do
    [
      fn -> :timer.sleep(200); IO.puts 1 end,
      fn -> :timer.sleep(400); IO.puts 2 end,
      fn -> :timer.sleep(600); IO.puts 3 end,
      fn -> :timer.sleep(800); IO.puts 4 end
    ]
    |> Enum.map(&Task.async/1)
    |> Enum.map(&Task.await/1)
  end
end
TaskModule.parallel()
IO.puts ""


IO.puts "## Process.monitor"
pid = spawn fn ->
  :timer.sleep(100)
  raise RuntimeError
end
Process.monitor pid

receive do
  {:DOWN, ref, :process, pid, msg} ->
    IO.inspect ref
    IO.inspect pid
    IO.inspect msg
end
IO.puts ""


IO.puts "## OTP: Process.link"
pid = spawn fn ->
  pid = spawn fn ->
    :timer.sleep(500)
    raise RuntimeError
  end
  Process.link pid
  IO.puts "start to link with other process"
  :timer.sleep(2000)
  IO.puts "never display this message"
end
Process.monitor pid
IO.puts "start the linking process"
IO.inspect pid

receive do
  {:DOWN, ref, :process, pid, msg} ->
    IO.puts "killed the linking process"
    IO.inspect pid
    IO.inspect msg
end
IO.puts ""


IO.puts "## OTP: spawn_link"
pid = spawn fn ->
  pid = spawn_link fn ->
    :timer.sleep(500)
    raise RuntimeError
  end
  IO.puts "start to link with other process"
  :timer.sleep(2000)
  IO.puts "never display this message"
end
Process.monitor pid
IO.puts "start the linking process"
IO.inspect pid

receive do
  {:DOWN, ref, :process, pid, msg} ->
    IO.puts "killed the linking process"
    IO.inspect pid
    IO.inspect msg
end
IO.puts ""


IO.puts "## OTP: Supervisor"
defmodule Echo.Server do
  use GenServer
  
  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end
  
  def crash! do
    GenServer.cast(__MODULE__, :crash)
  end
  
  def handle_cast(:crash, _) do
    raise RuntimeError, message: "Opps!"
  end
  
  def echo(term) do
    GenServer.call(__MODULE__, {:echo, term})
  end
  
  def handle_call({:echo, str}, _, s) do
    {:reply, str, s}
  end
end

defmodule SupervisorTest do
  def run do
    import Supervisor.Spec, warn: false
    
    children = [worker(Echo.Server, [])]
    opts = [
      strategy: :one_for_one,
      name: Echo.Supervisor
    ]
    IO.inspect {:ok, pid} = Supervisor.start_link(children, opts)
    IO.inspect Echo.Server.echo "hey"
    IO.inspect Echo.Server.crash!
    :timer.sleep(1000)
    IO.inspect Echo.Server.echo "foo"
  end
end
# SupervisorTest.run

IO.puts "### ModuleBased Supervisor"
defmodule Echo.Supervisor do
  use Supervisor
  
  def start_link do
    Supervisor.start_link(__MODULE__, [])
  end
  
  def init([]) do
    children = [
      worker(Echo.Server, [])
    ]
    opts = [
      strategy: :one_for_one,
      name: Echo.Supervisor
    ]
    supervise(children, opts)
  end
end

defmodule ModuleBasedSupervisorTest do
  def run do
    IO.inspect {:ok, pid} = Echo.Supervisor.start_link()
    IO.inspect Echo.Server.echo "hey"
    IO.inspect Echo.Server.crash!
    :timer.sleep(1000)
    IO.inspect Echo.Server.echo "foo"
  end
end
ModuleBasedSupervisorTest.run()
IO.puts ""
