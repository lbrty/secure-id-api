defmodule Core.Repo.Migrations.AlterDocumentsTableSetNonNullConstraints do
  use Ecto.Migration

  def change do
    alter table(:documents) do
      modify :original_name, :string, null: false
    end
  end
end
