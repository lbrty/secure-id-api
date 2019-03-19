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
  secret_key_base: "1InI/+ih763K1lcIF8jX/MBGGMJE+opykgnphXF2Ozll2KQvTkZYRNXEODuu2pld",
  render_errors: [view: IdpWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: IdpWeb.PubSub, adapter: Phoenix.PubSub.PG2]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
