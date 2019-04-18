defmodule IdpWeb.Schema.AuthResolvers do
  use IdpWeb.Schema.Errors

  alias Auth
  alias Idp.EctoHelpers

  def login(%{email: email, password: password}, _info) do
    with {:ok, user} <- Auth.login_with_email_pass(email, password),
         {:ok, jwt, _} <- IdpWeb.Guardian.encode_and_sign(user) do

      case user.is_active do
        true -> {:ok, %{token: jwt}}
        _ -> @user_not_active
      end
    else
      {:error, :invalid_credentials} -> @invalid_credentials
      {:error, :user_not_found} -> @user_not_found
    end
  end

  def register(user, _info) do
    case Auth.register(user) do
      {:error, :already_exists} -> @user_already_exists

      {:error, %Ecto.Changeset{} = changeset} ->
        EctoHelpers.action_wrapped(fn ->
          {:error, changeset}
        end)

      {:ok, result} -> {:ok, result}
    end
  end
end
