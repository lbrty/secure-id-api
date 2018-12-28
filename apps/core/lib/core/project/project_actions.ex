defmodule Core.ProjectActions do
  alias Core.{Repo, Project, Idp}
  import Ecto.Query

  def list() do
    Project |> Repo.all()
  end

  def create(params) do
    params
    |> Project.changeset()
    |> Repo.insert!()
  end

  def update(%{id: id, project: project_params}) do
    Project
    |> Repo.get!(id)
    |> Project.changeset(project_params)
    |> Repo.update()
  end

  def delete(%{id: id}) do
    Project
    |> Repo.get!(id)
    |> Repo.delete()
  end

  def people_count(project) do
    Repo.aggregate(
      from(idp in Idp, where: [project_id: ^project.id]),
      :count,
      :id
    )
  end
end
