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
