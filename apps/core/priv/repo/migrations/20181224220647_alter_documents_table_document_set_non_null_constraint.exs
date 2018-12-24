defmodule Core.Repo.Migrations.AlterDocumentsTableDocumentSetNonNullConstraint do
  use Ecto.Migration

  def change do
    alter table(:documents) do
      modify :document, :string, null: false
    end
  end
end
