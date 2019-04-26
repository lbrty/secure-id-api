defmodule IdpWeb.Schema.CountryMutations do
  use Absinthe.Schema.Notation
  alias IdpWeb.Schema.CountryResolvers

  object :country_mutations do
    @desc "Create country"
    field :create_country, :country do
      arg(:country, :country_input)

      middleware(IdpWeb.AuthRequired)
      middleware(IdpWeb.OnlyActiveUser)
      middleware(IdpWeb.OnlyAdmin)

      resolve(&CountryResolvers.create/3)
    end
  end
end
