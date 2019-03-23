defmodule Idp.Repo.Migrations.CreateCountries do
  use Ecto.Migration

  def change do
    create table(:countries) do
      add :title, :string

      timestamps()
    end

    create unique_index(:countries, [:title])
  end
end
