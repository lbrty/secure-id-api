defmodule Auth do
  @moduledoc false
  import Comeonin.Argon2, only: [checkpw: 2]
  alias Idp.Users

  def login_with_email_pass(email, given_pass) do
    user = Users.get_by_email(email)

    cond do
      user && checkpw(given_pass, user.password_hash) ->
        {:ok, user}

      user ->
        {:error, :invalid_credentials}

      true ->
        {:error, :user_not_found}
    end
  end

  def register(data) do
    user = Users.get_by_email(data.email)

    if user do
      {:error, :already_exists}
    else
      case Users.create_user(data) do
        {:ok, %Users.User{} = _user} ->
          {:ok, %{result: :ok}}

        error_result -> error_result
      end
    end
  end

  def hash_password(password) do
    Argon2.hash_pwd_salt(password)
  end
end
