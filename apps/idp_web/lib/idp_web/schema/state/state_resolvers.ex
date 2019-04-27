defmodule IdpWeb.Schema.StateResolvers do
  use IdpWeb.Schema.Errors

  alias Idp.Geo.States
  alias Idp.EctoHelpers

  def create(_parent, state, _ctx) do
    EctoHelpers.action_wrapped(fn ->
      States.create_state(state)
    end)
  end

  def list(_parent, args, _context) when args == %{} do
    {:ok, States.list_states()}
  end

  def list(_parent, %{name: name}, _context) do
    {:ok, States.get_by_name(name)}
  end

  def update(_parent, %{state_id: id, name: name}, _ctx) do
    case States.get_state(id) do
      nil ->
        @not_found

      state ->
        EctoHelpers.action_wrapped(fn ->
          States.update_state(state, %{name: name})
        end)
    end
  end

  def delete(_parent, %{state_id: id}, _ctx) do
    case States.get_state(id) do
      nil ->
        @not_found

      state ->
        EctoHelpers.action_wrapped(fn ->
          States.delete_state(state)
        end)
    end
  end
end
