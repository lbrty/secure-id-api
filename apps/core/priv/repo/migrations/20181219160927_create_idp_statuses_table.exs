defmodule Core.Repo.Migrations.CreateIdpStatusesTable do
  use Ecto.Migration

  def change do
    create table(:idp_statuses) do
      add :title, :string

      timestamps()
    end

    create index(:idp_statuses, [:title])
  end
end
