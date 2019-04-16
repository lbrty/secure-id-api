defmodule IdpWeb.AuthRequired do
  @behaviour Absinthe.Middleware

  use IdpWeb.Schema.Errors
  alias Absinthe.Resolution

  def call(resolution = %{context: %{user: _}}, _config) do
    resolution
  end

  def call(resolution, _config) do
    resolution
    |> Resolution.put_result(@not_authenticated)
  end
end
