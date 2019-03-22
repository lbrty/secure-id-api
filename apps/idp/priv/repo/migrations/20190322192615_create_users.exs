defmodule Idp.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :full_name, :string
      add :password_hash, :string
      add :is_active, :boolean, default: false, null: false
      add :is_superuser, :boolean, default: false, null: false

      timestamps()
    end

  end
end
