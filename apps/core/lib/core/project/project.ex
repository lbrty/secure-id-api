defmodule Core.Project do
  @moduledoc false
  use Core.Model
  import Ecto.Changeset

  schema "projects" do
    field(:project_name, :string)
    field(:description, :string)

    # Related permissions
    has_many(:permissions, Core.Permission)

    timestamps()
  end

  @doc false
  def changeset(params) do
    %Core.Project{} |> changeset(params)
  end

  @doc false
  def changeset(%Core.Project{} = project, params) do
    project
    |> cast(params, [:project_name, :description])
    |> validate_required([:project_name, :description])
  end
end
