defmodule Core.WorldActions do
  alias Core.Repo
  alias Core.Country

  def create_country(params) do
    params
    |> Country.changeset
    |> Repo.insert!
  end

  def update_country(%{id: id, country: params}) do
    Country
    |> Repo.get!(id)
    |> Country.changeset(params)
    |> Repo.update
  end

  def delete_country(%{id: id}) do
    Country
    |> Repo.get!(id)
    |> Repo.delete
  end
end
