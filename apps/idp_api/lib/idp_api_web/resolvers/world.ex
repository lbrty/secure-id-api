defmodule IdpApiWeb.Resolvers.World do
  alias Core.Repo
  alias Core.{Country, State}
  alias Core.WorldActions

  ###################
  # Country resolvers
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

  #################
  # State resolvers
  def list_states(_parent, _args, _resolution) do
    {:ok, State |> Repo.all}
  end

  def create_state(_parent, args, _resolution) do
    {:ok, WorldActions.create_state(args)}
  end

  def update_state(_parent, args, _resolution) do
    WorldActions.update_state(args)
  end

  def delete_state(_parent, args, _resolution) do
    WorldActions.delete_state(args)
  end
end
