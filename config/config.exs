# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :roiimPpaysafe,
  ecto_repos: [RoiimPpaysafe.Repo]

# Configures the endpoint
config :roiimPpaysafe, RoiimPpaysafeWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "bjS/eITjGggp/u4Yh5Nv+T5GVdt29Trs4VHJc4CjcL3qSTmU7DULfxluQ2VicQ/C",
  render_errors: [view: RoiimPpaysafeWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: RoiimPpaysafe.PubSub,
  live_view: [signing_salt: "J6ir2Wti"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :roiimPpaysafe,
  paysafe_api_username: "private-7751",
  paysafe_api_password: "B-qa2-0-5f031cdd-0-302d0214496be84732a01f690268d3b8eb72e5b8ccf94e2202150085913117f2e1a8531505ee8ccfc8e98df3cf1748"
# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
