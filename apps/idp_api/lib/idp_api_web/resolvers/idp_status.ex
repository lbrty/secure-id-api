defmodule IdpApiWeb.Resolvers.IdpStatus do
  alias Core.IdpStatus
  alias Core.StatusActions

  def list(_parent, _args, _resolution) do
    {:ok, IdpStatus |> Core.Repo.all}
  end

  def create_status(_parent, args, _resolution) do
    {:ok, StatusActions.create(args)}
  end

  def update_status(_parent, args, _resolution) do
    StatusActions.update(args)
  end

  def delete_status(_parent, args, _resolution) do
    StatusActions.delete(args)
  end
end
