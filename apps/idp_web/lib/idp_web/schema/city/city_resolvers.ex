defmodule IdpWeb.Schema.CityResolvers do
  use IdpWeb.Schema.Errors

  alias Idp.Geo.Cities
  alias Idp.EctoHelpers

  def create(_parent, city, _ctx) do
    EctoHelpers.action_wrapped(fn ->
      Cities.create_city(city)
    end)
  end

  def list(_parent, args, _context) when args == %{} do
    {:ok, Cities.list_cities()}
  end

  def list(_parent, %{name: name}, _context) do
    {:ok, Cities.get_by_name(name)}
  end

  def update(_parent, %{city_id: id, name: name}, _ctx) do
    case Cities.get_city(id) do
      nil ->
        @not_found

      city ->
        EctoHelpers.action_wrapped(fn ->
          Cities.update_city(city, %{name: name})
        end)
    end
  end

  def delete(_parent, %{city_id: id}, _ctx) do
    case Cities.get_city(id) do
      nil ->
        @not_found

      city ->
        EctoHelpers.action_wrapped(fn ->
          Cities.delete_city(city)
        end)
    end
  end
end
