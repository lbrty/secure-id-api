defmodule IdpApiWeb.Helpers.AuthHelpers do
  @moduledoc false
  import Comeonin.Argon2, only: [checkpw: 2]
  alias Core.{Repo, User}

  def login_with_email_pass(email, given_pass) do
    user = Repo.get_by(User, email: String.downcase(email))

    cond do
      user && checkpw(given_pass, user.password_hash) ->
        {:ok, user}

      user ->
        {:error, "Incorrect login credentials"}

      true ->
        {:error, "User not found"}
    end
  end
end
