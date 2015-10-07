IO.puts '## quote/unquote'
IO.inspect(ast = quote do: String)
IO.inspect(ast = quote do
  (unquote ast).length("aaaa")
end)
IO.inspect(Code.eval_quoted ast)
IO.puts ''


IO.puts '## Macro'
defmodule MacroModule do
  defmacro value(ast) do
    ast
  end
  
  defmacro value_impl(ast) do
    ast
  end
  
  def call do
    value(IO.puts("1"))
  end
end
MacroModule.call

defmodule UsingMacroModule do
  require MacroModule
  
  def use_macro do
    MacroModule.value(IO.puts("2"))
  end
end
UsingMacroModule.use_macro
IO.puts ''
