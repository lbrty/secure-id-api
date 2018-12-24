defmodule Core.Document do
  use Core.Model
  use Arc.Ecto.Schema
  import Ecto.Changeset

  @required_fields [:original_name, :document, :idp]

  schema "documents" do
    field(:external_id, Ecto.UUID, autogenerate: true)
    field(:original_name, :string)
    field(:document, Core.DocumentUploader.Type)

    belongs_to(:idp, Core.Idp)

    timestamps()
  end

  @doc false
  def changeset(params) do
    %Core.Document{} |> changeset(params)
  end

  @doc false
  def changeset(%Core.Document{} = document, params) do
    document
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
  end
end
