defmodule IdpWeb.Schema.StateQueries do
  use Absinthe.Schema.Notation
  alias IdpWeb.Schema.StateResolvers

  object :state_queries do
    @desc "Get states"
    field :states, list_of(:state) do
      arg(:name, :string)

      middleware(IdpWeb.AuthRequired)
      middleware(IdpWeb.OnlyActiveUser)

      resolve(&StateResolvers.list/3)
    end
  end
end
