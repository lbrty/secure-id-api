defmodule IdpApiWeb.Resolvers.User do
  alias Core.{Repo, UserActions, User}

  def list(_parent, _args, _resolution) do
    {:ok, User |> Repo.all}
  end

  def create_user(_parent, args, _resolution) do
    {:ok, UserActions.create_user(args)}
  end
end
