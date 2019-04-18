defmodule IdpWeb.Schema.UserResolvers do
  use IdpWeb.Schema.Errors
  alias Idp.Users

  def list(_parent, _args, _context) do
    {:ok, Users.list_users()}
  end
end
