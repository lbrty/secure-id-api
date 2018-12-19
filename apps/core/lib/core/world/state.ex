defmodule Core.State do
  use Ecto.Schema

  @timestamp_opts [type: :utc_datetime]
  schema "states" do
    field(:title, :string)

    belongs_to(:country, Core.Country)
    has_many(:cities, Core.City)

    timestamps()
  end
end
