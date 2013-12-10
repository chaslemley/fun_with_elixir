defmodule MyList do
  def caesar(str, n), do: Enum.map(str, &_caesar(&1, n))
  def mapsum([h|t], func), do: _mapsum(t, func, func.(h))
  def max([h|t]), do: _max(t, h)
  def span(from, to), do: _span(from, to)

  defp _caesar(a, n) when a + n > 122, do: a + n - 26
  defp _caesar(a, n), do: a + n

  defp _mapsum([], _, val), do: val
  defp _mapsum([h|t], func, val), do: _mapsum(t, func, val + func.(h))

  defp _max([], val), do: val
  defp _max([h|t], val) when h >= val, do: _max(t, h)
  defp _max([h|t], val) when h < val, do: _max(t, val)

  defp _span(from, to) when from < to, do: [from|_span(from + 1, to)]
  defp _span(from, to) when from == to, do: [from]
end

MyList.mapsum([1, 2, 3], &(&1 * &1)) |> IO.inspect
MyList.max([1, 100, 2, 3, 12, 100, -10]) |> IO.inspect
MyList.caesar('ryvkve', 13) |> IO.inspect
MyList.span(1, 100) |> IO.inspect
