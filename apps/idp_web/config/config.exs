# Since configuration is shared in umbrella projects, this file
# should only configure the :idp_web application itself
# and only for organization purposes. All other config goes to
# the umbrella root.
use Mix.Config

# General application configuration
config :idp_web,
  ecto_repos: [Idp.Repo],
  generators: [context_app: :idp]

# Configures the endpoint
config :idp_web, IdpWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: System.get_env("SECRET_KEY_BASE"),
  render_errors: [view: IdpWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: IdpWeb.PubSub, adapter: Phoenix.PubSub.PG2]

config :idp_web, IdpWeb.Guardian,
  issuer: "idp_web",
  varify_module: Guardian.JWT,
  ttl: {7, :days},
  allow_drift: 1000,
  verify_issuer: true,
  secret_key: System.get_env("SECRET_KEY")

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
