defmodule Core.Repo.Migrations.CreateSpheresTable do
  use Ecto.Migration

  def change do
    create table(:spheres) do
      add :title, :string
      add :type, :string

      timestamps()
    end

    create unique_index(:spheres, [:title])
  end
end
