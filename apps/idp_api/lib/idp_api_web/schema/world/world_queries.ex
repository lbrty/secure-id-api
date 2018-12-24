defmodule IdpApiWeb.Schema.WorldQueries do
  use Absinthe.Schema.Notation
  alias IdpApiWeb.Resolvers.World

  object :world_queries do
    @desc "Get all countries"
    field :countries, list_of(:country) do
      resolve &World.list_countries/3
    end
  end
end
