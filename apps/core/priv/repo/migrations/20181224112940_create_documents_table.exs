defmodule Core.Repo.Migrations.CreateDocumentsTable do
  use Ecto.Migration

  def change do
    create table(:documents) do
      add :external_id, :uuid, null: false
      add :original_name, :string
      add :document, :string

      timestamps()
    end

    create index(:documents, [:external_id])
  end
end
