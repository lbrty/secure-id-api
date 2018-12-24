defmodule Core.IdpStatus do
  @moduledoc false
  use Core.Model

  schema "idp_statuses" do
    field(:title, :string)

    timestamps()
  end

  @doc false
  def changeset(params) do
    %Core.IdpStatus{} |> changeset(params)
  end

  @doc false
  def changeset(%Core.IdpStatus{} = status, params) do
    status
    |> cast(params, [:title])
    |> validate_required([:title])
  end
end
