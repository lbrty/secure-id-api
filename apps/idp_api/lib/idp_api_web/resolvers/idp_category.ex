defmodule IdpApiWeb.Resolvers.IdpCategory do
  alias Core.{IdpCategory, CategoryActions}

  def list(_parent, _args, _resolution) do
    {:ok, IdpCategory |> Repo.all}
  end

  def create_category(_parent, args, _resolution) do
    {:ok, CategoryActions.create(args)}
  end

  def update_category(_parent, args, _resolution) do
    CategoryActions.update(args)
  end

  def delete_category(_parent, args, _resolution) do
    CategoryActions.delete(args)
  end
end
