defmodule Idp.Geo.City do
  use Idp.Model
  alias Idp.Geo.State

  schema "cities" do
    field :title, :string
    belongs_to :state, State

    timestamps()
  end

  @required_fields [:title, :state_id]

  @doc false
  def changeset(city, attrs) do
    city
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
    |> validate_length(:title, min: 3, max: 40)
  end
end
