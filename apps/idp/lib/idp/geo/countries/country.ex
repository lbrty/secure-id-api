defmodule Idp.Geo.Countries.Country do
  use Idp.Model
  alias Idp.Geo.States.State

  schema "countries" do
    field :title, :string
    has_many :states, State

    timestamps()
  end

  @doc false
  def changeset(country, attrs) do
    country
    |> cast(attrs, [:title])
    |> validate_required([:title])
    |> validate_length(:title, min: 3, max: 40)
    |> unique_constraint(:title)
  end
end
