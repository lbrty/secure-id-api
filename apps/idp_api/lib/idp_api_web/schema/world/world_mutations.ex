defmodule IdpApiWeb.Schema.WorldMutations do
  use Absinthe.Schema.Notation
  alias IdpApiWeb.Resolvers.World

  object :world_mutations do
    # Country mutations
    @desc "Create country"
    field :create_country, :country do
      arg :title, non_null(:string)

      resolve &World.create_country/3
    end

    @desc "Update country"
    field :update_country, type: :country do
      arg :id, non_null(:integer)
      arg :country, :update_country_params

      resolve &World.update_country/3
    end

    @desc "Delete country"
    field :delete_country, type: :country do
      arg :id, non_null(:integer)

      resolve &World.delete_country/3
    end

    # State mutations
    @desc "Create state"
    field :create_state, :state do
      arg :title, non_null(:string)
      arg :country_id, non_null(:integer)

      resolve &World.create_state/3
    end

    @desc "Update state"
    field :update_state, type: :state do
      arg :id, non_null(:integer)
      arg :state, :update_state_params

      resolve &World.update_state/3
    end

    @desc "Delete state"
    field :delete_state, type: :state do
      arg :id, non_null(:integer)

      resolve &World.delete_state/3
    end

    # City mutations
    @desc "Create city"
    field :create_city, :city do
      arg :title, non_null(:string)
      arg :state_id, non_null(:integer)

      resolve &World.create_city/3
    end

    @desc "Update city"
    field :update_city, type: :city do
      arg :id, non_null(:integer)
      arg :city, :update_city_params

      resolve &World.update_city/3
    end

    @desc "Delete city"
    field :delete_city, type: :city do
      arg :id, non_null(:integer)

      resolve &World.delete_city/3
    end
  end
end
