defmodule QuickSort do
  def run([pivot|rest]) do
    left  = Enum.filter(rest, fn(x) -> x <  pivot end)
    right = Enum.filter(rest, fn(x) -> x >= pivot end)
    run(left) ++ [pivot] ++ run(right)
  end
  
  def run([]), do: []
end

IO.inspect QuickSort.run([3,44,-1,2,4,100,0,-3,9,12])
