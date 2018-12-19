defmodule Core.Repo.Migrations.AddUniqueIndexForIdpStatuses do
  use Ecto.Migration

  def change do
    drop index(:idp_statuses, [:title])
    create unique_index(:idp_statuses, [:title])
  end
end
