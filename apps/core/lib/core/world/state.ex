defmodule Core.State do
  @moduledoc false
  use Core.Model

  schema "states" do
    field(:title, :string)

    belongs_to(:country, Core.Country)
    has_many(:cities, Core.City)

    timestamps()
  end

  @doc false
  def changeset(params) do
    %Core.State{} |> changeset(params)
  end

  @doc false
  def changeset(%Core.State{} = state, params) do
    state
    |> cast(params, [:title, :country_id])
    |> validate_required([:title, :country_id])
  end
end
