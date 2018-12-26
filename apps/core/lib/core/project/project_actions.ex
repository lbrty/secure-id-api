defmodule Core.ProjectActions do
  alias Core.{Repo, Project}

  def list() do
    Project |> Repo.all
  end

  def create(params) do
    params
    |> Project.changeset
    |> Repo.insert!
  end

  def update(%{id: id, project: project_params}) do
    Project
    |> Repo.get!(id)
    |> Project.changeset(project_params)
    |> Repo.update
  end

  def delete(%{id: id}) do
    Project
    |> Repo.get!(id)
    |> Repo.delete
  end
end
