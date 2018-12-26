defmodule Core.TagActions do
  alias Core.{Repo, Tag}

  def list() do
    Tag |> Repo.all
  end

  def create(params) do
    params
    |> Tag.changeset
    |> Repo.insert!
  end

  def update(%{id: id, tag: params}) do
    Tag
    |> Repo.get!(id)
    |> Tag.changeset(params)
    |> Repo.update
  end

  def delete(%{id: id}) do
    Tag
    |> Repo.get!(id)
    |> Repo.delete
  end
end
