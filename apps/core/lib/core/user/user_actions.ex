defmodule Core.UserActions do
  alias Core.{User, Repo}

  def list() do
    User |> Repo.all
  end

  def create_user(params) do
    params
    |> User.changeset
    |> Repo.insert!
  end
end
