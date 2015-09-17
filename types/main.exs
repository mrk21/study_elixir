IO.puts "## Integer"
IO.inspect 10    # decimal
IO.inspect 0b101 # binary
IO.inspect 0o12  # octet
IO.inspect 0x0a  # hex
IO.puts ""


IO.puts "## Float"
IO.inspect 1.0
IO.inspect 1.0e3
IO.puts ""


IO.puts "## Atom"
IO.inspect :symbol
IO.inspect :"contain spaces"
IO.inspect nil == :nil # nil is atom
IO.puts ""


IO.puts "## Boolean"
IO.inspect true
IO.inspect false
IO.inspect true  == :true  # true is atom
IO.inspect false == :false # false is atom
IO.puts ""


IO.puts "## Binary"
IO.inspect <<65>>            # ASCII: A
IO.inspect <<65, 66>>        # ASCII string: AB
IO.inspect <<256>> == <<0>>  # overflow
IO.inspect <<-1>> == <<255>> # underflow
IO.inspect <<1>> == <<255>>  # underflow
IO.inspect <<1::float>> == <<63, 240, 0,0,0,0,0,0>> # byte sequence
IO.puts ""


IO.puts "## String"
IO.inspect "hey"
IO.inspect 'hey'
IO.inspect "hey" == <<104,101,121>> # binary sequence
IO.inspect 'hey' == [104,101,121]   # list of integer
IO.puts ""


IO.puts "## List"
IO.inspect [1,2,3]
IO.inspect [true, [1,2,3], "hey"]
IO.inspect [1 | [2,3]] # [1,2,3]
IO.inspect [1, 2 | []] # [1,2]
IO.puts ""


IO.puts "## Tuple"
IO.inspect {:ok, 30}
IO.inspect {1,2,3}
IO.puts ""


IO.puts "## Map"
IO.inspect %{}
IO.inspect %{"hoge" => 300}
IO.inspect %{hoge: 300}
IO.inspect %{hoge: %{fuga: 20}}
IO.inspect %{hoge: 300}.hoge                 # 300
IO.inspect Map.get(%{hoge: 300}, :hoge)      # 300
IO.inspect Map.put(%{hoge: 300}, :fuga, 200) # %{fuga: 200, hoge: 300}
IO.puts ""


IO.puts "## Range"
IO.inspect 1..4
IO.inspect 1..-4
IO.inspect 1.2..1.5
IO.inspect (1.5 in 1.2..1.8) # true
IO.puts ""


IO.puts "## Function"
IO.inspect fn (x,y) -> x * y end         # #Function<0.27242777 in file:types/main.exs>
IO.inspect (fn (x,y) -> x * y end).(4,2) # 8
IO.inspect &(&1 * &2)                    # &:erlang.*/2
IO.inspect (&(&1 * &2)).(4,2)            # 8
IO.inspect Enum.each([1,2], &IO.puts/1)  # 1\n2\n:ok
IO.puts ""
