defmodule IdpWeb.Schema.PermissionResolvers do
  use IdpWeb.Schema.Errors

  alias Idp.{Permissions, Projects, Users}
  alias Idp.EctoHelpers

  def list(_parent, args, %{context: %{user: _session_user}}) do
    {:ok, Permissions.list_permissions()}
  end
end
