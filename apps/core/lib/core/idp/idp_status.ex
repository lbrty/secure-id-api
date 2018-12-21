defmodule Core.IdpStatus do
  @moduledoc false
  use Ecto.Schema

  schema "idp_statuses" do
    field(:title, :string)

    timestamps()
  end
end
