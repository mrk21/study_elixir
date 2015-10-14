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
