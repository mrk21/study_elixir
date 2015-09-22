IO.puts "## base"
[x, y] = [1, 2]
IO.inspect [x, y]

{1, x, 3} = {1, 2, 3}
IO.inspect x
IO.puts ""


IO.puts "## underscore"
[head | _] = [1,2,3]
IO.inspect [head]

{y, _m, _d} = {2015, 4, 30}
IO.inspect [y, _m, _d]
IO.puts ""


IO.puts "## PinOperator"
x = 1
[^x, y, 3] = [1, 2, 3]
#[^x, y, 3] = [5, 2, 3] # MatchError
IO.puts ""
