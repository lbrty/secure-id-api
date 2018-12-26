defmodule IdpApiWeb.Resolvers.User do
  alias Core.UserActions

  def list(_parent, _args, _resolution) do
    {:ok, UserActions.list()}
  end

  def create_user(_parent, args, _resolution) do
    {:ok, UserActions.create_user(args)}
  end
end
