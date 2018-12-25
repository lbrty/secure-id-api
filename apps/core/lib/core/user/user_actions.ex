defmodule Core.UserActions do
  alias Core.{User, Repo}

  def create_user(params) do
    params
    |> User.changeset
    |> Repo.insert!
  end
end
