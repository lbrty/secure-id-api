defmodule Core.Repo.Migrations.CreateCountriesTable do
  use Ecto.Migration

  def change do
    create table(:countries) do
      add :title, :string

      timestamps()
    end

    create index(:countries, [:title])
  end
end
