use Mix.Config

config :auth, Auth.Repo,
  database: "secure_idp_#{Mix.env}",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"
