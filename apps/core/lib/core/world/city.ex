defmodule Core.City do
  @moduledoc false
  use Core.Model

  @required_fields [:title, :state_id]

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
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
    |> foreign_key_constraint(:state_id)
  end
end
