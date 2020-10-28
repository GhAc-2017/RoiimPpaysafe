defmodule RoiimPpaysafeWeb.PaymentController do
  use RoiimPpaysafeWeb, :controller
  def new(conn, _params) do
    render conn, "new.html"
  end
end
