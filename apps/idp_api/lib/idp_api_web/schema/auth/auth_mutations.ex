defmodule IdpApiWeb.Schema.AuthMutations do
  use Absinthe.Schema.Notation
  alias IdpApiWeb.Resolvers.Auth

  object :auth_mutations do
    @desc "Authenticate user"
    field :login, :session do
      arg :email, non_null(:string)
      arg :password, non_null(:string)

      resolve &Auth.login/2
    end
  end
end
