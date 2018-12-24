defmodule Core.Tag do
  @moduledoc false
  use Core.Schema
  import Ecto.Changeset

  schema "tags" do
    field(:name, :string)
  end

  @doc false
  def changeset(params) do
    %Core.Tag{} |> changeset(params)
  end

  @doc false
  def changeset(%Core.Tag{} = tag, params) do
    tag
    |> cast(params, [:title])
    |> validate_required([:title])
  end
end
