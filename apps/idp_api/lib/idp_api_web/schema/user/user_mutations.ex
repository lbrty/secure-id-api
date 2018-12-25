defmodule IdpApiWeb.Schema.UserMutations do
  use Absinthe.Schema.Notation
  alias IdpApiWeb.Resolvers.User

  object :user_mutations do
    @desc "Create user"
    field :create_user, :user do
      arg :last_name, non_null(:string)
      arg :first_name, non_null(:string)
      arg :email, non_null(:string)

      # passwords
      arg :password, non_null(:string)

      # states
      arg :is_active, :boolean
      arg :is_admin, :boolean

      resolve &User.create_user/3
    end
  end
end
