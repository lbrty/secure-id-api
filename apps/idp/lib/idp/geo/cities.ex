defmodule Idp.Geo.Cities do
  @moduledoc """
  The Cities context.
  """
  use Idp.Query
  alias Idp.Geo.Cities.City

  @doc """
  Returns the list of cities.

  ## Examples

      iex> list_cities()
      [%City{}, ...]

  """
  def list_cities do
    Repo.all(City)
  end

  @doc """
  Gets a single City.

  Returns `nil` if City does not exist.

  ## Examples

      iex> get_city(123)
      %City{}

      iex> get_city(456)
      nil

  """
  def get_city(id), do: Repo.get(City, id)

  def get_by_name(name) do
    query = from(
      c in City,
      # TODO: look if like statement injections possible
      where: ilike(c.name, ^"%#{name}%")
    )

    Repo.all(query)
  end

  @doc """
  Creates a new City.

  ## Examples

      iex> create_city(%{field: value})
      {:ok, %City{}}

      iex> create_city(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_city(attrs \\ %{}) do
    %City{}
    |> City.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a City.

  ## Examples

      iex> update_city(city, %{field: new_value})
      {:ok, %City{}}

      iex> update_city(city, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_city(%City{} = city, attrs) do
    city
    |> City.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a City.

  ## Examples

      iex> delete_city(city)
      {:ok, %City{}}

      iex> delete_city(city)
      {:error, %Ecto.Changeset{}}

  """
  def delete_city(%City{} = city) do
    Repo.delete(city)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking city changes.

  ## Examples

      iex> change_city(city)
      %Ecto.Changeset{source: %City{}}

  """
  def change_city(%City{} = city) do
    City.changeset(city, %{})
  end
end
