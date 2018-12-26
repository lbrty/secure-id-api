defmodule IdpApiWeb.Resolvers.Auth do
  alias IdpApiWeb.Helpers.AuthHelpers

  def login(%{email: email, password: password}, _info) do
    with {:ok, user} <- AuthHelpers.login_with_email_pass(email, password),
         {:ok, jwt, _} <- IdpApi.Guardian.encode_and_sign(user) do

      {:ok, %{token: jwt}}

    end
  end
end
