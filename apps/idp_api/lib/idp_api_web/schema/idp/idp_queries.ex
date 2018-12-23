defmodule IdpApiWeb.Schema.IdpQueries do
  use Absinthe.Schema.Notation
  alias IdpApiWeb.Resolvers

  object :idp_queries do
    @desc "Get vulnerability categories"
    field :idp_categories, list_of(:idp_category) do
      resolve &Resolvers.IdpCategory.list/3
    end
  end
end
