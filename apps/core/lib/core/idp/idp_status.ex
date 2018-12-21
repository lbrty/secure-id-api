defmodule Core.IdpStatus do
  use Ecto.Schema

  schema "idp_statuses" do
    field(:title, :string)

    timestamps()
  end
end
