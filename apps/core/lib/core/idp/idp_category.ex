defmodule Core.IdpCategory do
  @moduledoc false
  use Core.Schema

  # Vulnerability category
  schema "idp_categories" do
    field(:title, :string)

    timestamps()
  end
end
