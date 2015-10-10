send self(), {:hello, "world"}

IO.inspect(receive do
  {:hello, msg} -> msg
  {:world, _} -> "won't match"
end)
