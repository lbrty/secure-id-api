defmodule Core.CategoryActions do
  alias Core.{Repo, IdpCategory}

  def list() do
    IdpCategory |> Repo.all
  end

  def create(params) do
    params
    |> IdpCategory.changeset
    |> Repo.insert!
  end

  def update(%{id: id, category: params}) do
    IdpCategory
    |> Repo.get!(id)
    |> IdpCategory.changeset(params)
    |> Repo.update
  end

  def delete(%{id: id}) do
    IdpCategory
    |> Repo.get!(id)
    |> Repo.delete
  end
end
