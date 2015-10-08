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

IO.puts '### my_assert'
defmodule MyAssert do
  defmacro my_assert(expr) do
    {operator, _, [lhs, rhs]} = expr
    quote do
      expr_str = "#{unquote(lhs)} #{unquote(operator)} #{unquote(rhs)}"
      if unquote(expr) do
        IO.puts "#{expr_str} is true"
      else
        IO.puts "#{expr_str} is false"
      end
    end
  end
  
  def call do
    a = 1
    my_assert(a == 1)
    my_assert(a == 2)
  end
end

MyAssert.call
