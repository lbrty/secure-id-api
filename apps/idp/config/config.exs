# Since configuration is shared in umbrella projects, this file
# should only configure the :idp application itself
# and only for organization purposes. All other config goes to
# the umbrella root.
use Mix.Config

config :idp,
  ecto_repos: [Idp.Repo]

import_config "#{Mix.env()}.exs"
