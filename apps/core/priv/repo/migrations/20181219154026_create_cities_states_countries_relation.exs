defmodule Core.Repo.Migrations.CreateCitiesStatesCountriesRelation do
  use Ecto.Migration

  def change do
    alter table(:cities) do
      add :state_id, references(:states, on_delete: :delete_all)
    end

    alter table(:states) do
      add :country_id, references(:countries, on_delete: :delete_all)
    end
  end
end
