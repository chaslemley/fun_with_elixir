defmodule Chain do
  def counter(next_pid) do
    receive do
      n ->
        next_pid <- n + 1
    end
  end

  def create_processes(n) do
    last = Enum.reduce 1..n, self,
             fn (_,send_to) ->
               spawn(Chain, :counter, [send_to])
             end

    # start the count by sending
    last <- 0

    # and wait for the result to come back to us
    receive do
      final_answer when is_integer(final_answer) ->
        "Result is #{inspect(final_answer)}"
    end
  end

  def run(n) do
    IO.puts inspect :timer.tc(Chain, :create_processes, [n])
  end
end

# {134505, "Result is 10000"}
# {4036785, "Result is 400000"}
# {12378946, "Result is 1000000"}

# elixir --erl "+P 1000000" -r 13_WorkingWithMultipleProcess-1.exs -e "Chain.run(1_000_000)"
