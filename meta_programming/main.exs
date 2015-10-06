IO.puts '## quote/unquote'
IO.inspect(ast = quote do: String)
IO.inspect(ast = quote do
  (unquote ast).length("aaaa")
end)
IO.inspect(Code.eval_quoted ast)
IO.puts ''
