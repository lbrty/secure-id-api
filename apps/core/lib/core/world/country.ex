defmodule Core.Country do
  use Ecto.Schema

  @timestamp_opts [type: :utc_datetime]
  schema "countries" do
    field(:title, :string)

    has_many(:states, Core.State)

    timestamps()
  end
end
