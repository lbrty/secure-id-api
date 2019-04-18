defmodule IdpWeb.Schema.ProjectResolvers do
  use IdpWeb.Schema.Errors

  alias Idp.Projects
  alias Idp.EctoHelpers

  def create(_parent, project, _context) do
    Projects.create_project(project)
  end

  def list(_parent, _args, %{context: %{user: user}}) do
    case user.is_superuser do
      true -> {:ok, Projects.list_projects()}
      _ -> {:ok, Projects.list_for_user(user)}
    end
  end

  def update(_parent, %{project_id: pid, project: to_update}, _) do
    project = Projects.get_project(pid)

    action_for_project(project, fn ->
      EctoHelpers.action_wrapped(fn ->
        Projects.update_project(project, to_update)
      end)
    end)
  end

  def delete(_parent, %{project_id: pid}, _) do
    project = Projects.get_project(pid)

    action_for_project(project, fn ->
      EctoHelpers.action_wrapped(fn ->
        Projects.delete_project(project)
      end)
    end)
  end

  defp action_for_project(nil, _fun), do: @project_not_found
  defp action_for_project(_project, fun), do: fun.()
end
