defmodule Idp.Geo do
  use Idp.Query

  defdelegate list_countries, to: Idp.Geo.Countries
  defdelegate get_country(id), to: Idp.Geo.Countries
  defdelegate create_country(attrs), to: Idp.Geo.Countries
  defdelegate update_country(country, attrs), to: Idp.Geo.Countries
  defdelegate delete_country(country), to: Idp.Geo.Countries

  defdelegate list_states, to: Idp.Geo.States
  defdelegate get_state(id), to: Idp.Geo.States
  defdelegate create_state(attrs), to: Idp.Geo.States
  defdelegate update_state(state, attrs), to: Idp.Geo.States
  defdelegate delete_state(state), to: Idp.Geo.States

  defdelegate list_cities, to: Idp.Geo.Cities
  defdelegate get_city(id), to: Idp.Geo.Cities
  defdelegate create_city(attrs), to: Idp.Geo.Cities
  defdelegate update_city(city, attrs), to: Idp.Geo.Cities
  defdelegate delete_city(city), to: Idp.Geo.Cities
end
