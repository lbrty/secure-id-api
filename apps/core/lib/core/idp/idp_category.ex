defmodule Core.IdpCategory do
  use Ecto.Schema

  @timestamp_opts [type: :utc_datetime]

  # Vulnerability category
  schema "idp_categories" do
    field(:title, :string)

    timestamps()
  end
end
