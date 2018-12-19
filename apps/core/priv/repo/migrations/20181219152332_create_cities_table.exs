defmodule Core.Repo.Migrations.CreateCitiesTable do
  use Ecto.Migration

  def change do
    create table(:cities) do
      add :title, :string

      timestamps()
    end

    create index(:cities, [:title])
  end
end
