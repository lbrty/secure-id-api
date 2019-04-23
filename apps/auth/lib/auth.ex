defmodule Auth do
  @moduledoc false
  import Comeonin.Argon2, only: [checkpw: 2]

  def authenticate(user, given_pass) do
    if checkpw(given_pass, user.password_hash) do
      {:ok, :ok}
    else
      {:error, :invalid_credentials}
    end
  end

  def password_valid?(password, password_hash) do
    checkpw(password, password_hash)
  end

  def hash_password(password) do
    Argon2.hash_pwd_salt(password)
  end
end
