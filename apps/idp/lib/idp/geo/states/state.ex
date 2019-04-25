defmodule Idp.Geo.States.State do
  use Idp.Model
  alias Idp.Geo.Countries.Country
  alias Idp.Geo.Cities.City

  schema "states" do
    field :name, :string
    belongs_to :country, Country
    has_many :cities, City

    timestamps()
  end

  @required_fields [:name, :country_id]

  @doc false
  def changeset(state, attrs) do
    state
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
    |> validate_length(:name, min: 3, max: 40)
  end
end
