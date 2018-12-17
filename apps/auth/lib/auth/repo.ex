defmodule Auth.Repo do
  use Ecto.Repo,
    otp_app: :corauthe,
    adapter: Ecto.Adapters.Postgres
end
