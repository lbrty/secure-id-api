defmodule Core.IdpCategory do
  @moduledoc false
  use Core.Model

  # Vulnerability category
  schema "idp_categories" do
    field(:title, :string)

    timestamps()
  end

  @doc false
  def changeset(params) do
    %Core.IdpCategory{} |> changeset(params)
  end

  @doc false
  def changeset(%Core.IdpCategory{} = category, params) do
    category
    |> cast(params, [:title])
    |> validate_required([:title])
  end
end
