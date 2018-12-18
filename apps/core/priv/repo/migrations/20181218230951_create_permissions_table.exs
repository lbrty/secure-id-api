defmodule Core.Repo.Migrations.CreatePermissionsTable do
  use Ecto.Migration

  def change do
    create table(:permissions) do
      add :view, :boolean, default: true
      add :edit, :boolean, default: false
      add :create, :boolean, default: false
      add :delete, :boolean, default: false

      # Means personal information like address, phone.
      add :view_personal, :boolean, default: false

      # Can view uploaded documents?
      add :view_documents, :boolean, default: false

      add :user, references(:users, on_delete: :delete_all)
      add :project, references(:projects, on_delete: :delete_all)

      timestamps()
    end
  end
end
