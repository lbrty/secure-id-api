defmodule Core.State do
  use Core.Schema

  schema "states" do
    field(:title, :string)

    belongs_to(:country, Core.Country)
    has_many(:cities, Core.City)

    timestamps()
  end
end
