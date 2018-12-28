defmodule Core.Repo.Migrations.CreateSupportsSpheresJoinTable do
  use Ecto.Migration
  alias Core.{Support, Sphere}

  def change do
    create table(:supports_spheres) do
      add :support_id, references(Support, on_delete: :delete_all)
      add :sphere_id, references(Sphere, on_delete: :delete_all)
    end

    create unique_index(:supports_spheres, [:support_id, :sphere_id])
  end
end
