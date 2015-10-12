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


IO.puts "## OTP"
defmodule GenServerSample do
  use GenServer
  
  def start_link do
    GenServer.start_link(__MODULE__, 0)
  end
  
  def next(pid) do
    GenServer.call(pid, :next)
  end
  
  def handle_call(:next, _from, current) do
    {:reply, current, current+1}
  end
end
IO.inspect {:ok, pid} = GenServerSample.start_link
IO.inspect GenServerSample.next(pid)
IO.inspect GenServerSample.next(pid)
IO.puts ""
