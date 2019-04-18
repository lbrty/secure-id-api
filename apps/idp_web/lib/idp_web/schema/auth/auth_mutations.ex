defmodule IdpWeb.Schema.AuthMutations do
  @moduledoc """
  Mutations for authentication.
  Notes:
    Only admins are allowed to create new accounts
    and share access so these actions must be protected.
  """
  use Absinthe.Schema.Notation
  alias IdpWeb.Schema.AuthResolvers

  object :auth_mutations do
    @desc "Authenticate user"
    field :login, :session do
      arg :email, non_null(:string)
      arg :password, non_null(:string)

      middleware IdpWeb.AuthRequired
      middleware IdpWeb.OnlyActiveUser
      middleware IdpWeb.OnlyAdmin

      resolve &AuthResolvers.login/2
    end

    @desc "Register user"
    field :register, :text_result do
      arg :full_name, non_null(:string)
      arg :email, non_null(:string)
      arg :password, non_null(:string)

      middleware IdpWeb.AuthRequired
      middleware IdpWeb.OnlyActiveUser
      middleware IdpWeb.OnlyAdmin

      resolve &AuthResolvers.register/2
    end
  end
end
