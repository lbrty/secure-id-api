defmodule Core.Document do
  use Core.Model
  use Arc.Ecto.Schema

  schema "documents" do
    field(:external_id, Ecto.UUID, autogenerate: true)
    field(:original_name, :string)
    field(:document, Core.DocumentUploader.Type)

    belongs_to(:idp, Core.Idp)

    timestamps()
  end
end
