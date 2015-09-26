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
