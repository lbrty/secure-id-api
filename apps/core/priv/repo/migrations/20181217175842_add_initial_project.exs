defmodule Core.Repo.Migrations.AddInitialProject do
  use Ecto.Migration

  def change do
    create table("projects") do
      add :project_name, :string, size: 50
      add :description, :string, null: true

      timestamps(type: :utc_datetime)
    end
  end
end
