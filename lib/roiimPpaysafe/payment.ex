defmodule RoiimPpaysafe.Payment do
  alias RoiimPpaysafe.Repo

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

  def merchant_ref_generator(length\\32) do
    :crypto.strong_rand_bytes(length) |> Base.url_encode64 |> binary_part(0, length)
  end

  def process_payment(params) do
    url = "#{@paysafe_base_url}paymenthub/v1/payments"
    # token = generate_payement_handle_token()

    # details =
    #   Jason.encode!(%{
    #     merchantRefNum: merchant_ref_generator(),
    #     merchantCustomerId: "roiim1000",
    #     amount: 3000,
    #     currencyCode: "USD",
    #     paymentHandleToken: token,
    #     description: "paying you"
    #   })

    details = Jason.encode!(params)

    case HTTPoison.post(url, details, @paysafe_header) do
      {:ok, %HTTPoison.Response{body: response_body}} ->
        case Jason.decode(response_body) do
          {:ok, result} ->
            case Map.has_key?(result, "error") do
              true ->
                {:error, result}
              _ ->
                {:ok, "transaction #{result["id"]} completed successfully"}
            end

          _ ->
            {:error, "not_found"}
        end

      _ ->
        {:error, "not_found"}
    end
  end

  def generate_payement_handle_token() do
    url = "#{@paysafe_base_url}paymenthub/v1/paymenthandles"

    payment_req = %{
      merchantRefNum: merchant_ref_generator(),
      transactionType: "PAYMENT",
      card: %{
        cardNum: "5191330000004415",
        cardExpiry: %{
          month: 10,
          year: 2020
        },
        cvv: "111",
        holderName: "Ayan"
      },
      paymentType: "CARD",
      amount: 3000,
      currencyCode: "USD",
      customerIp: "172.0.0.1",
      billingDetails: %{
        street: "100 Queen",
        city: "Toronto",
        zip: "M5H 2N2",
        country: "CA"
      },
      returnLinks: [
        %{
          rel: "on_completed",
          href: "https://amazon.com/payment/return/success",
          method: "GET"
        },
        %{
          rel: "on_failed",
          href: "https://amazon.com/payment/return/failed",
          method: "GET"
        },
        %{
          rel: "default",
          href: "https://amazon.com/payment/return/failed",
          method: "GET"
        }
      ]
    }

    case HTTPoison.post(url, Jason.encode!(payment_req), @paysafe_header) do
      {:ok, %HTTPoison.Response{body: response_body}} ->
        result = Jason.decode!(response_body)
        result["paymentHandleToken"]

      _->
        generate_payement_handle_token()
    end
  end

end
