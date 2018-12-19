defmodule Core.Repo.Migrations.CreateStatesTable do
  use Ecto.Migration

  def change do
    create table(:states) do
      add :title, :string

      timestamps()
    end

    create index(:states, [:title])
  end
end
