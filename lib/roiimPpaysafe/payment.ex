defmodule RoiimPpaysafe.Payment do
  @paysafe_base_url "https://api.test.paysafe.com/"

  @paysafe_header [
    Authorization:
      "Basic #{
        Base.encode64(
          "#{Application.get_env(:roiimPpaysafe, :paysafe_api_username)}:#{
            Application.get_env(:roiimPpaysafe, :paysafe_api_password)
          }"
        )
      }",
      "Content-Type": "application/json",
      Simulator: "EXTERNAL"
  ]

  def process_payment() do
    url = "#{@paysafe_base_url}paymenthub/v1/payments"
    details = Jason.encode!(%{
      merchantRefNum: "aryan113",
      merchantCustomerId: "roiim1000",
      amount: 30000,
      currencyCode: "USD",
      paymentHandleToken: "SCQw7OwVEptkkD8M",
      description: "paying you"
    })

    case HTTPoison.post(url, details, @paysafe_header) do
      {:ok, %HTTPoison.Response{body: response_body}} ->
        case Jason.decode(response_body) do
          {:ok, result} ->
            case Map.has_key?(result, "error") do
              true -> {:error, result}
              _-> {:ok, result}
            end

          _->
            {:error, "not_found"}
        end

      _->
        {:error, "not_found"}
    end
  end

  def generate_payement_handle_token() do
  end
end
