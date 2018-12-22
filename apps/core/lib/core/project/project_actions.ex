defmodule Core.ProjectActions do
  alias Core.Repo
  alias Core.Project

  def create(params) do
    params
    |> Project.changeset
    |> Repo.insert!
  end

  def update(%{id: id, project: project_params}) do
    Repo.get!(Project, id)
    |> Project.changeset(project_params)
    |> Repo.update
  end

  def delete(%{id: id}) do
    Repo.get!(Project, id)
    |> Repo.delete
  end
end
