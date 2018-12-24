defmodule IdpApiWeb.Resolvers.Tags do
  alias Core.{Repo, Tag, TagActions}

  def list(_parent, _args, _resolution) do
    {:ok, Tag |> Repo.all}
  end

  def create_tag(_parent, args, _resolution) do
    {:ok, TagActions.create(args)}
  end

  def update_tag(_parent, args, _resolution) do
    TagActions.update(args)
  end

  def delete_tag(_parent, args, _resolution) do
    TagActions.delete(args)
  end
end
