defmodule IdpWeb.AuthRequired do
  @behaviour Absinthe.Middleware

  use IdpWeb.Schema.Errors
  alias Absinthe.Resolution

  def call(resolution = %{context: context}, _config) do
    case Map.has_key?(context, :user) do
      true -> resolution
      _ ->
        resolution
        |> Resolution.put_result(@not_authenticated)
    end
  end
end
