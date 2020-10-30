defmodule RoiimPpaysafeWeb.PaymentController do
  use RoiimPpaysafeWeb, :controller
  alias RoiimPpaysafe.Payment
  def new(conn, _params) do
    render conn, "new.html"
  end

  def create(conn, params) do
  case Payment.process_payment(params) do
      {:ok, res} ->
        render(conn, "success.json", transaction_id: res)
      {:error, coz} ->
        render(conn, "error.json", msg: coz)
    end
  end
end
