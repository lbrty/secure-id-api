defmodule Core.Tag do
  @moduledoc false
  use Core.Model

  schema "tags" do
    field(:name, :string)

    timestamps()
  end

  @doc false
  def changeset(params) do
    %Core.Tag{} |> changeset(params)
  end

  @doc false
  def changeset(%Core.Tag{} = tag, params) do
    tag
    |> cast(params, [:name])
    |> validate_required([:name])
  end
end
