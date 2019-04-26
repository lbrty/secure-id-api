defmodule IdpWeb.Schema.CountryResolvers do
  use IdpWeb.Schema.Errors

  alias Idp.Geo.Countries
  alias Idp.EctoHelpers

  def create(_parent, %{country: country}, _ctx) do
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
end
