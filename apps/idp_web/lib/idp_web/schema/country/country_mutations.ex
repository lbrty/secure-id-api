defmodule IdpWeb.Schema.CountryMutations do
  use Absinthe.Schema.Notation
  alias IdpWeb.Schema.CountryResolvers

  object :country_mutations do
    @desc "Create country"
    field :create_country, :country do
      arg(:name, non_null(:string))

      middleware(IdpWeb.AuthRequired)
      middleware(IdpWeb.OnlyActiveUser)
      middleware(IdpWeb.OnlyAdmin)

      resolve(&CountryResolvers.create/3)
    end

    @desc "Update country"
    field :update_country, :country do
      arg(:country_id, non_null(:integer))
      arg(:name, non_null(:string))

      middleware(IdpWeb.AuthRequired)
      middleware(IdpWeb.OnlyActiveUser)
      middleware(IdpWeb.OnlyAdmin)

      resolve(&CountryResolvers.update/3)
    end

    @desc "Delete country"
    field :delete_country, :country do
      arg(:country_id, non_null(:integer))

      middleware(IdpWeb.AuthRequired)
      middleware(IdpWeb.OnlyActiveUser)
      middleware(IdpWeb.OnlyAdmin)

      resolve(&CountryResolvers.delete/3)
    end
  end
end
