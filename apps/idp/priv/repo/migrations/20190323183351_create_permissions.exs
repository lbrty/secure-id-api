defmodule Idp.Repo.Migrations.CreatePermissions do
  use Ecto.Migration

  def change do
    create table(:permissions) do
      add :can_create, :boolean, default: false, null: false
      add :can_read, :boolean, default: false, null: false
      add :can_update, :boolean, default: false, null: false
      add :can_delete, :boolean, default: false, null: false
      add :view_contacts, :boolean, default: false, null: false
      add :view_personal, :boolean, default: false, null: false
      add :view_documents, :boolean, default: false, null: false

      add :user_id, references(:users, on_delete: :delete_all)
      add :project_id, references(:projects, on_delete: :delete_all)

      timestamps()
    end

  end
end
