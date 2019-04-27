defmodule IdpWeb.Schema.CityQueries do
  use Absinthe.Schema.Notation
  alias IdpWeb.Schema.CityResolvers

  object :city_queries do
    @desc "Get cities"
    field :cities, list_of(:city) do
      arg(:name, :string)

      middleware(IdpWeb.AuthRequired)
      middleware(IdpWeb.OnlyActiveUser)

      resolve(&CityResolvers.list/3)
    end
  end
end
