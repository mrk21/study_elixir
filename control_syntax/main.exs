IO.puts "## case"
IO.inspect(case 2 do
  1 -> "one"
  2 -> "two"
end)
try do
  IO.inspect(case 3 do
    1 -> "one"
    2 -> "two"
  end)
rescue
  e in CaseClauseError -> IO.inspect e
end
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
try do
  IO.inspect(cond do
    2 == 1 -> "one"
    3 == 2 -> "two"
  end)
rescue
  e in CondClauseError -> IO.inspect e
end
IO.puts ""
