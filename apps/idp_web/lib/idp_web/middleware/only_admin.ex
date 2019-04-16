defmodule IdpWeb.OnlyAdmin do
  @moduledoc """
  Middleware checks if user in the current context is
  superuser before forwarding query further.
  """
  @behaviour Absinthe.Middleware

  use IdpWeb.Schema.Errors
  alias Absinthe.Resolution

  def call(resolution = %{context: context}, _config) do
    case Map.has_key?(context, :user) do
      true ->
        resolution
        |> is_admin(Map.get(context, :user))

      _ ->
        resolution
        |> Resolution.put_result(@permission_denied)
    end
  end

  defp is_admin(resolution, %{:is_superuser => true}) do
    resolution
  end

  defp is_admin(resolution, %{:is_superuser => nil}) do
    resolution
    |> Resolution.put_result(@permission_denied)
  end

  defp is_admin(resolution, %{:is_superuser => false}) do
    resolution
    |> Resolution.put_result(@permission_denied)
  end
end
