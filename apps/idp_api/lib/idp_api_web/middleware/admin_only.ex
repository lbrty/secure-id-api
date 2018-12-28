defmodule IdpApiWeb.Middleware.AdminOnly do
  @moduledoc """
  Check if `current_user` is admin otherwise
  return rejected resolution.
  """
  @behaviour Absinthe.Middleware

  def call(resolution = %{context: %{current_user: user}}, _) do
    if user.is_admin do
      resolution
    else
      deny(resolution)
    end
  end

  def call(resolution, _), do: deny(resolution)

  defp deny(resolution) do
    Absinthe.Resolution.put_result(resolution, {:error, "Not Authorized"})
  end
end
