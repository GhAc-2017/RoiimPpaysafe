defmodule RoiimPpaysafeWeb.PaymentController do
  use RoiimPpaysafeWeb, :controller
  alias RoiimPpaysafe.Payment
  def new(conn, _params) do
    render conn, "new.html"
  end

  def create(conn, _params) do
    # require IEx
    # IEx.pry
    case Payment.process_payment() do
      {:ok, res} ->
        require IEx
        IEx.pry
        IO.puts(res)
        conn
        |> put_flash(:info, "#{res} Payment done!")
      {:error, _coz} ->
        render conn, "new.html"
    end

  end

  def index() do

  end
end
