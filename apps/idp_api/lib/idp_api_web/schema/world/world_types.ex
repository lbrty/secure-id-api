defmodule IdpApiWeb.Schema.WorldTypes do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: Core.Repo

  input_object :update_country_params do
    field :title, :string
  end

  input_object :update_state_params do
    field :title, :string
    field :country_id, :integer
  end

  input_object :update_city_params do
    field :title, :string
    field :state_id, :integer
  end

  @desc "Country"
  object :country do
    field :id, :id
    field :title, :string
    field :states, list_of(:state), resolve: assoc(:states)
  end

  @desc "State"
  object :state do
    field :id, :id
    field :title, :string
    field :country, :country, resolve: assoc(:country)
  end

  @desc "City"
  object :city do
    field :id, :id
    field :title, :string
    field :state, :state, resolve: assoc(:state)
  end
end
