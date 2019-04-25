defmodule Idp.Geo.Cities.City do
  use Idp.Model
  alias Idp.Geo.States.State

  schema "cities" do
    field :name, :string
    belongs_to :state, State

    timestamps()
  end

  @required_fields [:name, :state_id]

  @doc false
  def changeset(city, attrs) do
    city
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
    |> validate_length(:name, min: 3, max: 40)
  end
end
