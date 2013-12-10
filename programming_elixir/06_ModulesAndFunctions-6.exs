defmodule Chop do
  def guess(actual, a..b) when actual < div(b + a, 2) do
    guess = div(b + a, 2)
    print_guess(guess)
    guess(actual, a..guess - 1)
  end

  def guess(actual, a..b) when actual > div(b + a, 2) do
    guess = div(b + a, 2)
    print_guess(guess)
    guess(actual, guess + 1..b)
  end

  def guess(actual, a..b) when actual == div(b + a, 2) do
    guess = div(b + a, 2)
    print_guess(guess)
    IO.puts(div(b + a, 2))
  end

  defp print_guess(guess), do: IO.puts("Is it #{guess}")
end

Chop.guess(273, 1..1000)
