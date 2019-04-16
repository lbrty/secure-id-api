defmodule Idp.Geo.State do
  use Idp.Model
  alias Idp.Geo.{Country, City}

  schema "states" do
    field :title, :string
    belongs_to :country, Country
    has_many :cities, City

    timestamps()
  end

  @required_fields [:title, :country_id]

  @doc false
  def changeset(state, attrs) do
    state
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
    |> validate_length(:title, min: 3, max: 40)
  end
end