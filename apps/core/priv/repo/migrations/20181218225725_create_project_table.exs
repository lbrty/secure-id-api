defmodule Core.Repo.Migrations.CreateProjectTable do
  use Ecto.Migration

  def change do
    create table(:projects) do
      add :project_name, :string
      add :description, :string

      timestamps()
    end

    create index(:projects, [:project_name])
  end
end
