defmodule Core.Country do
  use Core.Schema

  schema "countries" do
    field(:title, :string)

    has_many(:states, Core.State)

    timestamps()
  end
end
