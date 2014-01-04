defmodule Link do
  def spawn(parent) do
    parent <- "Hello"
  end
end

defmodule LinkMe do
  import Process, only: [ spawn_monitor: 3 ]
  def run do
    spawn_monitor(Link, :spawn, [self])

    :timer.sleep(500)
    handle_message
  end

  def handle_message do
    receive do
      message ->
        IO.inspect(message)
        handle_message
      after 500 ->
        exit(0)
    end
  end
end

LinkMe.run
