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
  end
end
