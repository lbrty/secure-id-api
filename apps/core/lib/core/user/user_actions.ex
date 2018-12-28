defmodule Core.UserActions do
  alias Core.{User, Repo}

  def get_by_id(user_id) do
    User |> Repo.get(user_id)
  end

  def list() do
    User |> Repo.all()
  end

  def create_user(params) do
    params
    |> User.changeset()
    |> Repo.insert!()
  end
end
