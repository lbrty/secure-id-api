defmodule IdpWeb.Schema.ProjectResolvers do
  use IdpWeb.Schema.Errors

  alias Idp.{Projects, Users}
  alias Idp.EctoHelpers

  def create(_parent, project, _context) do
    Projects.create_project(project)
  end

  @doc """
  When `%{} = args` given then we have
  our basic action is to check if `session_user`
  is superuser if so return all projects.
  Else return projects specific to `session_user`.
  And when arguments provided we check if
  given user exists if not `@user_not_found` returned,
  otherwise check if `session_user` is superuser
  if so then we return all projects for requested user.
  Else return projects specific to `session_user`.
  As a last resort return `@permission_denied` if
  nothing satisfies conditions.
  """
  def list(_parent, args, %{context: %{user: session_user}}) when args == %{} do
    case session_user.is_superuser do
      true -> {:ok, Projects.list_projects()}
      _ -> {:ok, Projects.list_for_user(session_user)}
    end
  end

  def list(_parent, %{user_id: uid}, %{context: %{user: session_user}}) do
    uid
    |> Users.get_user()
    |> list_for_user(session_user)
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

  defp list_for_user(nil, _session_user), do: @user_not_found

  defp list_for_user(user, %{is_superuser: true}) do
    {:ok, Projects.list_for_user(user)}
  end

  defp list_for_user(user, session_user) do
    cond do
      user.id == session_user.id -> {:ok, Projects.list_for_user(user)}
      true -> @permission_denied
    end
  end

  defp action_for_project(nil, _fun), do: @project_not_found
  defp action_for_project(_project, fun), do: fun.()
end
