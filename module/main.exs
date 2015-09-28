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
