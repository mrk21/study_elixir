IO.puts "## case"
IO.inspect(case 2 do
  1 -> "one"
  2 -> "two"
end)
IO.puts ""


IO.puts "## if"
IO.inspect(if 2 == 1 do
  "one"
else
  "two"
end)
IO.puts ""


IO.puts "## cond"
IO.inspect(cond do
  2 == 1 -> "one"
  2 == 2 -> "two"
end)
IO.puts ""
