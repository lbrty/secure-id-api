use Mix.Config

config :core, Core.Repo,
  database: "secure_idp_#{Mix.env}",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"
