defmodule Core.Repo.Migrations.CreateIdpCategoriesTable do
  use Ecto.Migration

  def change do
    create table(:idp_categories) do
      add :title, :string

      timestamps()
    end

    create unique_index(:idp_categories, [:title])
  end
end
