defmodule MyString do
  def center(list) do
    max_length = list |> Enum.map(&String.length/1) |> Enum.max
    _center(list, max_length)
  end

  defp _center(list, max_length) do
    list
      |> Enum.map(&_center_word(&1, max_length))
      |> Enum.map(&IO.puts/1)
  end

  defp _center_word(str, max_length) do
    word_length = String.length(str)
    spaces = round((max_length - word_length) / 2)
    String.rjust(str, spaces + word_length)
  end
end

MyString.center(["o", "chr", "istma", "streeoc", "hristmast"])
