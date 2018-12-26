defmodule IdpApiWeb.Resolvers.IdpCategory do
  alias Core.CategoryActions

  def list(_parent, _args, _resolution) do
    {:ok, CategoryActions.list()}
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
