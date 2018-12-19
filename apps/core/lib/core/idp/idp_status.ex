defmodule Core.IdpStatus do
  use Ecto.Schema

  @timestamp_opts [type: :utc_datetime]
  schema "idp_status" do
    field(:title, :string)

    timestamps()
  end
end
