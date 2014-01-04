defmodule Flinstones do
  def echo_process(parent) do
    receive do
      message ->
        parent <- message
    end
  end

  def run do
    p1 = spawn(Flinstones, :echo_process, [self])
    p2 = spawn(Flinstones, :echo_process, [self])

    p1 <- "fred"
    p2 <- "betty"
    # self <- :die

    handle_message
  end

  def handle_message do
    receive do
      message ->
        IO.puts "received #{message}"
        handle_message
    after 10 ->
      IO.puts "exiting"
      exit(0)
    end
  end
end

Flinstones.run
