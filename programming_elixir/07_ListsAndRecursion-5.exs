defmodule MyEnum do
  def all?(list, fun), do: _all?(list, fun, true)

  defp _all?([], fun, true), do: true
  defp _all?([h|t], fun, val) do
   if fun.(h), do: _all?(t, fun, true), else: false
  end

  def each(list, fun), do: _each(list, fun)

  defp _each([], _), do: :ok
  defp _each([h|t], fun) do
    fun.(h)
    _each(t, fun)
  end

  def filter(list, fun), do: _filter(list, fun, [])

  defp _filter([], _, list), do: list |> :lists.reverse
  defp _filter([h|t], fun, list) do
    if fun.(h) do
      _filter(t, fun, [h|list])
    else
      _filter(t, fun, list)
    end
  end

  def split(list, fun), do: _split(list, fun, [], [])

  defp _split([], fun, true_l, false_l), do: [true_l, false_l]
  defp _split([h|t], fun, true_l, false_l) do
    if fun.(h) do
      _split(t, fun, [h|true_l], false_l)
    else
      _split(t, fun, true_l, [h|false_l])
    end
  end

  def take(list, count), do: _take(list, count, [])

  defp _take([], n, new_list), do: new_list |> :lists.reverse
  defp _take(_, n, new_list) when length(new_list) == n, do: new_list |> :lists.reverse
  defp _take([h|t], count, new_list), do: _take(t, count, [h|new_list])
end

MyEnum.all?([1,2,3,4], &(&1 < 5)) |> IO.inspect
MyEnum.all?([1,2,3,4], &(&1 > 5)) |> IO.inspect
MyEnum.all?([], &(&1 > 5)) |> IO.inspect

MyEnum.each(["some", "example"], fn(x) -> IO.inspect x end)

MyEnum.filter([1,6,2,3,20,4, 5, 100], &(&1 > 5)) |> IO.inspect
Enum.filter([1,6,2,3,20,4, 5, 100], &(&1 > 5)) |> IO.inspect

MyEnum.split([1,6,2,3,20,4, 5, 100], &(&1 > 5)) |> IO.inspect

MyEnum.take([1,6,2,3,20,4, 5, 100], 16) |> IO.inspect
MyEnum.take([1,6,2,3,20,4, 5, 100], 6) |> IO.inspect
MyEnum.take([1,6,2,3,20,4, 5, 100], 0) |> IO.inspect
