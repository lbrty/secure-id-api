defmodule IdpWeb.Schema.AuthResolvers do
  alias Auth

  def login(%{email: email, password: password}, _info) do
    with {:ok, user} <- Auth.login_with_email_pass(email, password),
         {:ok, jwt, _} <- IdpWeb.Guardian.encode_and_sign(user) do

      {:ok, %{token: jwt}}

    end
  end

  def register(user, _info) do
    Auth.register(user)
  end
end
