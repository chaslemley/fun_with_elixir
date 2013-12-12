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

tax_rates = [ NC: 0.075, TX: 0.08 ]

orders = [
    [ id: 123, ship_to: :NC, net_amount: 100.00 ],
    [ id: 124, ship_to: :OK, net_amount:  35.50 ],
    [ id: 125, ship_to: :TX, net_amount:  24.00 ],
    [ id: 126, ship_to: :TX, net_amount:  44.80 ],
    [ id: 127, ship_to: :NC, net_amount:  25.00 ],
    [ id: 128, ship_to: :MA, net_amount:  10.00 ],
    [ id: 129, ship_to: :CA, net_amount: 102.00 ],
    [ id: 120, ship_to: :NC, net_amount:  50.00 ] ]

TaxApplier.order_totals(orders, tax_rates) |> IO.inspect
