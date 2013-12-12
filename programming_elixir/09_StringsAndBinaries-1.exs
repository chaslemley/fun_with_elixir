defmodule MyString do
  def is_printable?(list), do: Enum.all?(list, &(&1 >= ?  && &1 <= ?~))

  def anagram?(word1, word2), do: word1 == String.reverse(word2)
end

MyString.is_printable?('boo') |> IO.inspect
MyString.is_printable?('boo ~') |> IO.inspect
MyString.is_printable?('boo \b \t') |> IO.inspect
MyString.is_printable?(['\n']) |> IO.inspect

MyString.anagram?("name", "eman") |> IO.inspect
MyString.anagram?("name", "ddd") |> IO.inspect
