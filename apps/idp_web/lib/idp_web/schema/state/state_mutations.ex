defmodule IdpWeb.Schema.StateMutations do
  use Absinthe.Schema.Notation
  alias IdpWeb.Schema.StateResolvers

  object :state_mutations do
    @desc "Create state"
    field :create_state, :state do
      arg(:name, non_null(:string))
      arg(:country_id, non_null(:integer))

      middleware(IdpWeb.AuthRequired)
      middleware(IdpWeb.OnlyActiveUser)
      middleware(IdpWeb.OnlyAdmin)

      resolve(&StateResolvers.create/3)
    end

    @desc "Update state"
    field :update_state, :state do
      arg(:state_id, non_null(:integer))
      arg(:name, non_null(:string))

      middleware(IdpWeb.AuthRequired)
      middleware(IdpWeb.OnlyActiveUser)
      middleware(IdpWeb.OnlyAdmin)

      resolve(&StateResolvers.update/3)
    end

    @desc "Delete state"
    field :delete_state, :state do
      arg(:state_id, non_null(:integer))

      middleware(IdpWeb.AuthRequired)
      middleware(IdpWeb.OnlyActiveUser)
      middleware(IdpWeb.OnlyAdmin)

      resolve(&StateResolvers.delete/3)
    end
  end
end
