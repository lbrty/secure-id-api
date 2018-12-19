defmodule Core.City do
  use Ecto.Schema

  @timestamp_opts [type: :utc_datetime]
  schema "cities" do
    field(:title, :string)

    belongs_to(:state, Core.State)

    timestamps()
  end
end
