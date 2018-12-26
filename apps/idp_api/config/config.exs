# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :idp_api, IdpApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "HOelpBB3wt8rSSD2FCdlT5jwymLc2cNx8slc4mXjsbitGLXbjYg7lIQ8cZu3Hwiy",
  render_errors: [view: IdpApiWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: IdpApi.PubSub, adapter: Phoenix.PubSub.PG2]

config :idp_api, IdpApi.Guardian,
  issuer: "idp_api",
  varify_module: Guardian.JWT,
  ttl: {7, :days},
  allow_drift: 1000,
  verify_issuer: true,
  secret_key: System.get_env("SECRET_KEY")

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
