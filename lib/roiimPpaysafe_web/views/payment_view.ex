defmodule RoiimPpaysafeWeb.PaymentView do
  use RoiimPpaysafeWeb, :view

  def render("success.json", %{transaction_id: transaction_id}) do
    %{success_msg: transaction_id}
  end

  def render("error.json", %{msg: msg}) do
    %{error: msg}
  end
end
