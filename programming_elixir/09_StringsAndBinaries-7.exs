defmodule TaxApplier do
  def order_totals(orders, tax_rates) do
    lc order inlist orders do
      ship_to_state = order |> Dict.get(:ship_to)
      net_amount = order |> Dict.get(:net_amount)
      tax_rate = tax_rates |> Dict.get(ship_to_state, 0.0)
      total_amount = net_amount * (1 + tax_rate)

      order |> Dict.put(:total_amount, total_amount)
    end
  end
end

defmodule CsvOrders do
  def parse(filename) do
    { :ok, file } = File.open(filename, [:read])
    IO.read(file, :line) # headers

    IO.stream(file, :line)
      |> Enum.map(&_parse_order/1)
  end

  defp _parse_order(str) do
    [id, ship_to, net_amount] = String.strip(str) |> String.split(",")

    [ id: binary_to_integer(id),
      ship_to: binary_to_atom(ship_to),
      net_amount: binary_to_float(net_amount) ]
  end
end

tax_rates = [ NC: 0.075, TX: 0.08 ]

CsvOrders.parse("./support/order.csv")
  |> TaxApplier.order_totals(tax_rates)
  |> IO.inspect
