defmodule Core.Repo.Migrations.AddProjectNameIndex do
  use Ecto.Migration

  def change do
    create index("projects", [:project_name])
  end
end
