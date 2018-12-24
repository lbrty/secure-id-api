defmodule IdpApiWeb.Schema.WorldQueries do
  use Absinthe.Schema.Notation
  alias IdpApiWeb.Resolvers.World

  object :world_queries do
    @desc "Get all countries"
    field :countries, list_of(:country) do
      resolve &World.list_countries/3
    end

    @desc "Get all states"
    field :states, list_of(:state) do
      resolve &World.list_states/3
    end
  end
end
