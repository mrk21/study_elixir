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


IO.puts "## Pin operator"
try do
  x = 1
  [^x, y, 3] = [1, 2, 3]
  [^x, y, 3] = [5, 2, 3]
rescue
  e in MatchError -> IO.inspect e
end
IO.puts ""


IO.puts "## Main usage"
{:error, message} = File.read 'not_existed_file.txt'
IO.inspect message # :enoent

try do
  {:ok, res} = File.read 'not_exlisted_file.txt'
rescue
  e in MatchError -> IO.inspect e
end

[head | tail] = [1,2,3,4]
IO.inspect head
IO.inspect tail

IO.inspect(case File.read 'not_existed_file.txt' do
  {:ok, res} -> res
  {:error, :enoent} -> 'not existed'
  {:error, :eacces} -> 'can not read'
end)

IO.puts ""
