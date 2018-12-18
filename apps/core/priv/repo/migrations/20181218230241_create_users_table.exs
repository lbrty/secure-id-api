defmodule Core.Repo.Migrations.CreateUsersTable do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :first_name, :string
      add :last_name, :string
      add :email, :string
      add :password_hash, :string

      add :is_active, :boolean, default: true
      add :is_admin, :boolean, default: false

      timestamps()
    end

    create index(:users, [:first_name, :last_name])
    create unique_index(:users, [:email])
  end
end
