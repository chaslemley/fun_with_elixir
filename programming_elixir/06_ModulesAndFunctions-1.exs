defmodule Times do
  def double(n), do: n * 2
  def triple(n), do: n * 3
  def quadruple(n), do: double(n) + double(n)
end

Times.triple(5) |> IO.inspect

# iex
# c "06_ModulesAndFunctions-1.exs"
# Times.double(5)

# or

# iex 06_ModulesAndFunctions-1.exs
# Times.double(3)
