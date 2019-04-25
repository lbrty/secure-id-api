defmodule IdpWeb.Schema.CountryResolvers do
  use IdpWeb.Schema.Errors

  alias Idp.Geo.Countries
  alias Idp.EctoHelpers

  def list(_parent, args, _context) when args == %{} do
    {:ok, Countries.list_countries()}
  end

  def list(_parent, %{name: name}, _context) do
    EctoHelpers.action_wrapped(fn ->
      name
      |> Countries.get_by_name()
    end)
  end
end
