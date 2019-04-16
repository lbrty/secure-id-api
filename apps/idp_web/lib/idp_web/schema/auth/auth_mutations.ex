defmodule IdpWeb.Schema.AuthMutations do
  use Absinthe.Schema.Notation
  alias IdpWeb.Schema.AuthResolvers

  object :auth_mutations do
    @desc "Authenticate user"
    field :login, :session do
      arg :email, non_null(:string)
      arg :password, non_null(:string)

      resolve &AuthResolvers.login/2
    end

    @desc "Register user"
    field :register, :text_result do
      arg :full_name, non_null(:string)
      arg :email, non_null(:string)
      arg :password, non_null(:string)

      resolve &AuthResolvers.register/2
    end
  end
end
