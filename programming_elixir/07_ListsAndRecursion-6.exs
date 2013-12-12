defmodule MyList do
  def flatten(list), do: _flatten(list)

  defp _flatten([h|t]) when is_list(h) do
    [_flatten(h)|_flatten(t)]
  end

  defp _flatten([h|t]) do
    [h|_flatten(t)]
  end

  defp _flatten([]), do: []
end

# MyList.flatten([1, [ 2, 3, [4] ], 5, [[[6]]]]) |> IO.inspect
MyList.flatten([1, [2]]) |> IO.inspect

# is the head a list?
# Yes
  # take t
# No
  # push it on to the list
