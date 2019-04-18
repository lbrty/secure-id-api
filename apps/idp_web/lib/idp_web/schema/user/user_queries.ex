defmodule IdpWeb.Schema.UserQueries do
  use Absinthe.Schema.Notation
  alias IdpWeb.Schema.UserResolvers

  object :user_queries do
    @desc "Get all user"
    field :users, list_of(:user) do
      middleware IdpWeb.AuthRequired
      middleware IdpWeb.OnlyActiveUser
      middleware IdpWeb.OnlyAdmin

      resolve &UserResolvers.list/3
    end
  end
end
