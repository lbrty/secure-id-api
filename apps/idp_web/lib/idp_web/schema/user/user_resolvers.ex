defmodule IdpWeb.Schema.UserResolvers do
  use IdpWeb.Schema.Errors

  alias Idp.Users
  alias Idp.EctoHelpers

  def list(_parent, _args, _context) do
    {:ok, Users.list_users()}
  end

  def update(_parent, %{user_id: uid, fields: to_update}, _) do
    user = Users.get_user(uid)

    action_for_user(user, fn ->
      EctoHelpers.action_wrapped(fn ->
        Users.update_user(user, Map.put(to_update, :password_hash, user.password_hash))
      end)
    end)
  end

  defp action_for_user(nil, _fun), do: @user_not_found
  defp action_for_user(_user, fun), do: fun.()
end
