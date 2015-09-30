IO.puts  "## Base"
defmodule MyModule do
  def print(arg) do
    print_impl(arg)
  end
  
  defp print_impl(arg) do
    IO.inspect arg
  end
end

MyModule.print %{price: 298}
try do
  MyModule.print_impl %{price: 298}
rescue
  e in UndefinedFunctionError -> IO.inspect e
end
IO.puts ""


# arity: the number of operands
IO.puts "## Overload(provided by different arity)"
defmodule Overload do
  def hoge do
    1
  end
  
  def hoge(n) do
    n
  end
end

IO.inspect Overload.hoge
IO.inspect Overload.hoge(2)
IO.puts ""


IO.puts "## Default argument"
defmodule DefaultArgument do
  def value(v \\ 1) do
    v
  end
end

IO.inspect DefaultArgument.value
IO.inspect DefaultArgument.value(2)
IO.puts ""


IO.puts "## Guard Expression"
defmodule GuardExpression do
  def hoge(list) when is_list(list) do
    list
  end
end

IO.inspect GuardExpression.hoge([1,2,3])
try do
  IO.inspect GuardExpression.hoge(2)
rescue
  e in FunctionClauseError -> IO.inspect e
end
IO.puts ""


IO.puts "## Import"
defmodule Import do
  import Enum, only: [count: 1]
  
  def mycount(list) do
    count(list)
  end
end
IO.inspect Import.mycount([1,2,3])
try do
  Import.count([1,2,3])
rescue
  e in UndefinedFunctionError -> IO.inspect e
end
IO.puts ""
