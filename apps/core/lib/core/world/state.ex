defmodule Core.State do
  @moduledoc false
  use Core.Model

  schema "states" do
    field(:title, :string)

    belongs_to(:country, Core.Country)
    has_many(:cities, Core.City)

    timestamps()
  end
end
