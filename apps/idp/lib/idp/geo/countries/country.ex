defmodule Idp.Geo.Countries.Country do
  use Idp.Model
  alias Idp.Geo.States.State

  schema "countries" do
    field :name, :string
    has_many :states, State

    timestamps()
  end

  @doc false
  def changeset(country, attrs) do
    country
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> validate_length(:name, min: 3, max: 40)
    |> unique_constraint(:name)
  end
end
