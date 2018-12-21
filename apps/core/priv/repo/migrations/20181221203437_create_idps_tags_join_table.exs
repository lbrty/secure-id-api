defmodule Core.Repo.Migrations.CreateIdpsTagsJoinTable do
  use Ecto.Migration

  def change do
    create table(:idps_tags) do
      add :idp_id, references(:idps)
      add :tag_id, references(:tags)
    end

    create unique_index(:idps_tags, [:idp_id, :tag_id])
  end
end
