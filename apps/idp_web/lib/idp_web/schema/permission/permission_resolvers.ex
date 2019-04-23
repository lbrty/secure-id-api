defmodule IdpWeb.Schema.PermissionResolvers do
  use IdpWeb.Schema.Errors

  alias Idp.{Permissions, Projects, Users}
  alias Idp.EctoHelpers

  def list(_parent, args, _context) when args == %{} do
    {:ok, Permissions.list_permissions()}
  end

  def list(_parent, %{user_id: uid}, %{context: %{user: session_user}}) do
    uid
    |> Users.get_user()
    |> list_for_user(session_user)
  end

  def create(
    _parent,
    %{
      project_id: pid,
      user_id: uid,
      permission: permission
    },
    _context
  ) do
    EctoHelpers.action_wrapped(fn ->
      pid
      |> Projects.get_project()
      |> share_project(Users.get_user(uid), permission)
    end)
  end

  # Share project with user (create permission)
  defp share_project(nil, _user, _permission), do: @project_not_found
  defp share_project(_project, nil, _permission), do: @user_not_found
  defp share_project(project, user, permission) do
    permission
    |> Map.put(:project_id, project.id)
    |> Map.put(:user_id, user.id)
    |> Permissions.create_permission()
  end

  # List permissions for given user
  # Admins can see all permissions
  # for any given user. Where as
  # users can only query permissions
  # which only belong to them.
  defp list_for_user(nil, _), do: @not_found
  defp list_for_user(user, %{is_superuser: true}) do
    {:ok, Permissions.list_for_user(user)}
  end
  defp list_for_user(user, %{id: uid}) do
    case user.id do
      ^uid -> {:ok, Permissions.list_for_user(user)}
      _ -> @permission_denied
    end
  end
end
