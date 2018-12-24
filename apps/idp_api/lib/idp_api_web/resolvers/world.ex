defmodule IdpApiWeb.Resolvers.World do
  alias Core.Repo
  alias Core.Country
  alias Core.WorldActions

  def list_countries(_parent, _args, _resolution) do
    {:ok, Country |> Repo.all}
  end

  def create_country(_parent, args, _resolution) do
    {:ok, WorldActions.create_country(args)}
  end

  def update_country(_parent, args, _resolution) do
    WorldActions.update_country(args)
  end

  def delete_country(_parent, args, _resolution) do
    WorldActions.delete_country(args)
  end
end
