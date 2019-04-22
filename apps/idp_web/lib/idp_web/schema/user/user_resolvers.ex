defmodule IdpWeb.Schema.UserResolvers do
  use IdpWeb.Schema.Errors

  alias Idp.Users
  alias Idp.EctoHelpers

  def list(_parent, _args, _context) do
    {:ok, Users.list_users()}
  end

  @doc """
  Update user info.
  If `session_user` is superuser then
  allow any update. If `session_user`
  is the same user who requested update
  then also allow update, otherwise just
  return `@permission_denied` error.
  """
  def update(
    _parent,
    %{user_id: uid, fields: to_update},
    %{context: %{user: session_user}}
  ) do
    uid
    |> Users.get_user()
    |> action_for_user(fn user ->
      EctoHelpers.action_wrapped(fn ->
        cond do
          session_user.is_superuser ->
            Users.update_user(user, to_update)

          session_user.id == user.id ->
            Users.update_user(user, to_update)

          true ->
            @permission_denied
        end
      end)
    end)
  end

  def delete(_parent, %{user_id: uid}, _context) do
    uid
    |> Users.get_user()
    |> action_for_user(fn user ->
      EctoHelpers.action_wrapped(fn ->
        Users.delete_user(user)
      end)
    end)
  end

  def change_password(
    _parent,
    %{user_id: uid, passwords: to_update},
    %{context: %{user: session_user}}
  ) do
    uid
    |> Users.get_user()
    |> action_for_user(fn user ->
      EctoHelpers.action_wrapped(fn ->
        case session_user.is_superuser do
          true -> Users.force_change_password(user, to_update)
          _ -> Users.change_password(user, to_update)
        end
      end)
    end)
  end

  defp action_for_user(nil, _fun), do: @user_not_found
  defp action_for_user(user, fun), do: fun.(user)
end
