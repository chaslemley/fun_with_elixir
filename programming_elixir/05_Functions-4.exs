prefix = fn str -> &("#{str} #{&1}") end

IO.puts prefix.("Elixir").("Rocks")
IO.puts prefix.("Mrs.").("Smith")
