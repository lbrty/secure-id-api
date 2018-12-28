defmodule Core.Repo.Migrations.CreateSupportsTable do
  use Ecto.Migration

  def change do
    create table(:supports) do
      add :type, :string
      add :reason, :string
      add :status, :string

      add :consultant_id, references(User, on_delete: :nothing)
      add :idp_id, references(Idp, on_delete: :delete_all)
    end
  end
end
