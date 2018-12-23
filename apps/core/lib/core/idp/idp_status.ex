defmodule Core.IdpStatus do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  schema "idp_statuses" do
    field(:title, :string)

    timestamps()
  end

  @doc false
  def changeset(params) do
    %Core.IdpStatus{} |> changeset(params)
  end

  @doc false
  def changeset(%Core.IdpStatus{} = project, params) do
    project
    |> cast(params, [:title])
    |> validate_required([:title])
  end
end
