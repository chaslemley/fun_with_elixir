defmodule MyMath do
  def unsafe_calcuate(expr), do: elem(Code.eval_string(expr), 0)
  def calculate(expr) when is_list(expr) do
    expr
      |> String.from_char_list!
      |> _calculate
  end

  defp _calculate(str) when is_bitstring(str) do
    Regex.run(%r/([\d]+) ([\+\-\*\/]) ([\d]+)/, str)
      |> _calculate
  end

  defp _calculate([_, left, "+", right]), do: binary_to_integer(left) + binary_to_integer(right)
  defp _calculate([_, left, "-", right]), do: binary_to_integer(left) - binary_to_integer(right)
  defp _calculate([_, left, "*", right]), do: binary_to_integer(left) * binary_to_integer(right)
  defp _calculate([_, left, "/", right]), do: binary_to_integer(left) / binary_to_integer(right)
end

MyMath.calculate('150 + 30') |> IO.inspect
MyMath.calculate('150 - 30') |> IO.inspect
MyMath.calculate('150 * 30') |> IO.inspect
MyMath.calculate('150 / 30') |> IO.inspect

MyMath.unsafe_calcuate('150 / 30') |> IO.inspect
MyMath.unsafe_calcuate('150 / 30') |> IO.inspect

MyMath.unsafe_calcuate('234 / 30') |> IO.inspect
