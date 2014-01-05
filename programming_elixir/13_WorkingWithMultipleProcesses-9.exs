defmodule CatCounter do
  def counter(scheduler) do
    scheduler <- { :ready, self }
    receive do
      { :counter, { folder, search_term }, client } ->
        client <- { :answer, folder, cat_counter(folder, search_term), self }
        counter(scheduler)
      { :shutdown } ->
        exit(0)
    end
  end

  defp cat_counter(folder, search_term) do
    File.ls!(folder)
    |> Enum.map(&("#{folder}/#{&1}"))
    |> Enum.map(fn(file) -> file_counter(file, search_term) end)
    |> Enum.reduce &(&1 + &2)
  end

  defp file_counter(filename, search_term) do
    parse = File.read!(filename) |> String.to_char_list
    case parse do
      {:ok, char_list} ->
        Enum.chunk(char_list, String.length(search_term), 1)
        |> Enum.count &(&1 == String.to_char_list!(search_term))
      _ -> 0
    end
  end
end

defmodule Scheduler do

  def run(num_processes, module, func, to_calculate) do
    (1..num_processes)
    |> Enum.map(fn(_) -> spawn(module, func, [self]) end)
    |> schedule_processes(to_calculate, [])
  end

  defp schedule_processes(processes, queue, results) do
    receive do
      {:ready, pid} when length(queue) > 0 ->
        [ next | tail ] = queue
        pid <- {:counter, next, self}
        schedule_processes(processes, tail, results)

      {:ready, pid} ->
        pid <- {:shutdown}
        if length(processes) > 1 do
          schedule_processes(List.delete(processes, pid), queue, results)
        else
          Enum.sort(results, fn {n1,_}, {n2,_}  -> n1 <= n2 end)
        end

      {:answer, number, result, _pid} ->
        schedule_processes(processes, queue, [ {number, result} | results ])
    end
  end
end

to_process = [ { "/Users/chas/Projects/elixir/programming_elixir", "cat" } ]

Enum.each 1..10, fn num_processes ->
  {time, result} = :timer.tc(Scheduler, :run,
                               [num_processes, CatCounter, :counter, to_process])
  if num_processes == 1 do
    IO.puts inspect result
    IO.puts "\n #   time (s)"
  end
  :io.format "~2B     ~.2f~n", [num_processes, time/1000000.0]
end
