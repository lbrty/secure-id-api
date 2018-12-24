defmodule Core.Document do
  use Core.Model

  schema "documents" do
    field(:external_id, Ecto.UUID, autogenerate: true)
    field(:original_name, :string)
    field(:file, :string)

    belongs_to(:idp, Core.Idp)

    timestamps()
  end
end
