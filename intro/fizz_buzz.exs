fizz_buzz = fn
  {0, 0, _} -> "FizzBuzz"
  {0, _, _} -> "Fizz"
  {_, 0, _} -> "Buzz"
  {_, _, n} -> n
end

fizz_buzz_input = fn
  n -> {rem(n,3), rem(n,5), n}
end

IO.puts 1..100 |> Enum.map(fizz_buzz_input) |> Enum.map(fizz_buzz) |> Enum.join(" ")
