defmodule IdpApiWeb.Schema.UserQueries do
  use Absinthe.Schema.Notation
  alias IdpApiWeb.Resolvers.User

  object :user_queries do
    @desc "Get all users"
    field :users, list_of(:user) do
      resolve &User.list/3
    end
  end
end
