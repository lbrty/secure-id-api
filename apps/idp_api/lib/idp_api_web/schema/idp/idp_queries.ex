defmodule IdpApiWeb.Schema.IdpQueries do
  use Absinthe.Schema.Notation
  alias IdpApiWeb.Resolvers.{IdpCategory, IdpStatus}

  object :idp_queries do
    @desc "Get vulnerability categories"
    field :idp_categories, list_of(:idp_category) do
      resolve &IdpCategory.list/3
    end

    @desc "Get statuses"
    field :idp_statuses, list_of(:idp_status) do
      resolve &IdpStatus.list/3
    end
  end
end
