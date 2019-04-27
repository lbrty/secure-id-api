defmodule IdpWeb.Schema.CityMutations do
  use Absinthe.Schema.Notation
  alias IdpWeb.Schema.CityResolvers

  object :city_mutations do
    @desc "Create city"
    field :create_city, :city do
      arg(:name, non_null(:string))
      arg(:state_id, non_null(:id))

      middleware(IdpWeb.AuthRequired)
      middleware(IdpWeb.OnlyActiveUser)
      middleware(IdpWeb.OnlyAdmin)

      resolve(&CityResolvers.create/3)
    end

    @desc "Update city"
    field :update_city, :city do
      arg(:city_id, non_null(:id))
      arg(:name, non_null(:string))

      middleware(IdpWeb.AuthRequired)
      middleware(IdpWeb.OnlyActiveUser)
      middleware(IdpWeb.OnlyAdmin)

      resolve(&CityResolvers.update/3)
    end

    @desc "Delete city"
    field :delete_city, :city do
      arg(:city_id, non_null(:id))

      middleware(IdpWeb.AuthRequired)
      middleware(IdpWeb.OnlyActiveUser)
      middleware(IdpWeb.OnlyAdmin)

      resolve(&CityResolvers.delete/3)
    end
  end
end
