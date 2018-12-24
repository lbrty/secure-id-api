defmodule Core.WorldActions do
  alias Core.Repo
  alias Core.{Country, State, City}

  # Country actions
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

  # State actions
  def create_state(params) do
    params
    |> State.changeset
    |> Repo.insert!
  end

  def update_state(%{id: id, state: params}) do
    State
    |> Repo.get!(id)
    |> State.changeset(params)
    |> Repo.update
  end

  def delete_state(%{id: id}) do
    State
    |> Repo.get!(id)
    |> Repo.delete
  end

  # City actions
  def create_city(params) do
    params
    |> City.changeset
    |> Repo.insert!
  end

  def update_city(%{id: id, city: params}) do
    City
    |> Repo.get!(id)
    |> City.changeset(params)
    |> Repo.update
  end

  def delete_city(%{id: id}) do
    City
    |> Repo.get!(id)
    |> Repo.delete
  end
end
