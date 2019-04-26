defmodule IdpWeb.Schema.CountryResolvers do
  use IdpWeb.Schema.Errors

  alias Idp.Geo.Countries
  alias Idp.EctoHelpers

  def create(_parent, country, _ctx) do
    EctoHelpers.action_wrapped(fn ->
      Countries.create_country(country)
    end)
  end

  def list(_parent, args, _context) when args == %{} do
    {:ok, Countries.list_countries()}
  end

  def list(_parent, %{name: name}, _context) do
    {:ok, Countries.get_by_name(name)}
  end

  def update(_parent, %{country_id: id, name: name}, _ctx) do
    case Countries.get_country(id) do
      nil ->
        @not_found

      country ->
        EctoHelpers.action_wrapped(fn ->
          Countries.update_country(country, %{name: name})
        end)
    end
  end

  def delete(_parent, %{country_id: id}, _ctx) do
    case Countries.get_country(id) do
      nil ->
        @not_found

      country ->
        EctoHelpers.action_wrapped(fn ->
          Countries.delete_country(country)
        end)
    end
  end
end
