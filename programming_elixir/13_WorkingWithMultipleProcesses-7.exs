defmodule Parallel do
  def pmap(collection, fun) do
    me = self

    collection
  |>
    Enum.map(fn (elem) ->
       spawn_link fn ->
         sleep_time = Float.floor(50/elem)
         :timer.sleep(sleep_time)
         (me <- { self, fun.(elem) })
       end
     end)
  |>
    Enum.map(fn (pid) ->
      receive do { ^pid, result } -> result end
    end)
  end
end

Parallel.pmap([1,2,3,4,5], &(&1 * 2)) |> IO.inspect
