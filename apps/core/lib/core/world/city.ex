defmodule Core.City do
  @moduledoc false
  use Core.Model

  schema "cities" do
    field(:title, :string)

    belongs_to(:state, Core.State)

    timestamps()
  end

  @doc false
  def changeset(params) do
    %Core.City{} |> changeset(params)
  end

  @doc false
  def changeset(%Core.City{} = city, params) do
    city
    |> cast(params, [:title, :state_id])
    |> validate_required([:title, :state_id])
  end
end
