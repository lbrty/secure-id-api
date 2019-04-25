defmodule IdpWeb.Schema.CountryQueries do
  use Absinthe.Schema.Notation
  alias IdpWeb.Schema.CountryResolvers

  object :country_queries do
    @desc "Get countries"
    field :countries, list_of(:country) do
      arg(:name, :string)

      middleware(IdpWeb.AuthRequired)
      middleware(IdpWeb.OnlyActiveUser)

      resolve(&CountryResolvers.list/3)
    end
  end
end
