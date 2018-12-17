# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

## Logger
config :logger, level: :debug

## Repo
config :auth, ecto_repos: [Auth.Repo]

import_config "#{Mix.env}.exs"
