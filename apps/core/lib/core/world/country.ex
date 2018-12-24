defmodule Core.Country do
  @moduledoc false
  use Core.Model

  schema "countries" do
    field(:title, :string)

    has_many(:states, Core.State)

    timestamps()
  end

  @doc false
  def changeset(params) do
    %Core.Country{} |> changeset(params)
  end

  @doc false
  def changeset(%Core.Country{} = country, params) do
    country
    |> cast(params, [:title])
    |> validate_required([:title])
  end
end
