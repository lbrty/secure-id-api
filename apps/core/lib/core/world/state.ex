defmodule Core.State do
  @moduledoc false
  use Core.Model

  @required_fields [:title, :country_id]

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
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
    |> foreign_key_constraint(:state_id)
  end
end
