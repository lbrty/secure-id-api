defmodule IdpWeb.OnlyActiveUser do
  @moduledoc """
  Middleware checks if user in the current context is
  active before forwarding query further.
  """
  @behaviour Absinthe.Middleware

  use IdpWeb.Schema.Errors
  alias Absinthe.Resolution

  def call(resolution = %{context: context}, _config) do
    case Map.has_key?(context, :user) do
      true ->
        resolution
        |> is_active(Map.get(context, :user))

      _ ->
        resolution
        |> Resolution.put_result(@permission_denied)
    end
  end

  defp is_active(resolution, %{:is_active => true}) do
    resolution
  end

  defp is_active(resolution, %{:is_active => nil}) do
    resolution
    |> Resolution.put_result(@user_not_active)
  end

  defp is_active(resolution, %{:is_active => false}) do
    resolution
    |> Resolution.put_result(@user_not_active)
  end
end
