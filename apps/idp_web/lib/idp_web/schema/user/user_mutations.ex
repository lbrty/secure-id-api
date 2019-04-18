defmodule IdpWeb.Schema.UserMutations do
  use Absinthe.Schema.Notation
  alias IdpWeb.Schema.UserResolvers

  object :user_mutations do
    @desc "Update user"
    field :update_user, :user do
      arg :user_id, non_null(:integer)
      arg :fields, :update_user_params

      middleware IdpWeb.AuthRequired
      middleware IdpWeb.OnlyActiveUser
      middleware IdpWeb.OnlyAdmin

      resolve &UserResolvers.update/3
    end
  end
end
