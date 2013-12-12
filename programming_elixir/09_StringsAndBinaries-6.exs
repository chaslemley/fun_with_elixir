defmodule MySentence do
  def capitalize_sentence(sentence) do
    sentence
      |> String.split(". ")
      |> Enum.map(&String.capitalize/1)
      |> Enum.join(". ")
  end
end

MySentence.capitalize_sentence("oh. a DOG. woof. ") |> IO.inspect
