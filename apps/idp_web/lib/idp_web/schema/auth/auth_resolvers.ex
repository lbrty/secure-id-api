defmodule IdpWeb.Schema.AuthResolvers do
  use IdpWeb.Schema.Errors

  alias Auth
  alias Idp.Users
  alias Idp.EctoHelpers

  def login(%{email: email, password: password}, _info) do
    email
    |> Users.get_by_email()
    |> login_user(password)
  end

  def register(%{email: email} = payload, _info) do
    email
    |> Users.get_by_email()
    |> register_user(payload)
  end

  defp login_user(nil, _password), do: @user_not_found
  defp login_user(%{is_active: false}, _password) do
    @user_not_active
  end
  defp login_user(user, password) do
    with {:ok, _} <- Auth.authenticate(user, password),
         {:ok, jwt, _} <- IdpWeb.Guardian.encode_and_sign(user) do

        {:ok, %{token: jwt}}

    else
      {:error, :invalid_credentials} -> @invalid_credentials
    end
  end

  defp register_user(nil, payload) do
    case Users.register_user(payload) do
      {:error, %Ecto.Changeset{} = changeset} ->
        EctoHelpers.action_wrapped(fn ->
          {:error, changeset}
        end)

      {:ok, _result} ->
        {:ok, %{result: :ok}}
    end
  end

  defp register_user(%Users.User{} = _user, _payload) do
    @user_already_exists
  end
end
