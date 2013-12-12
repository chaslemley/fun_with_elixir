defmodule Primes do
  def upto(n) when n > 2 do
    lc i inlist span(2, n), is_prime?(i), do: i
  end

  defp is_prime?(2), do: true
  defp is_prime?(n) do
    span(2, n - 1) |> Enum.all? &(rem(n, &1) != 0)
  end
  defp span(from, to), do: _span(from, to)
  defp _span(from, to) when from < to, do: [from|_span(from + 1, to)]
  defp _span(from, to) when from == to, do: [from]
end

Primes.upto(100) |> IO.inspect
