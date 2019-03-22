defmodule IdpWeb.Context do
  @moduledoc """
  Prepares and attaches request context to `conn`.
  At the moment adds authenticated user if token
  presents in `Authotization` header and sets
  it to empty map if user is unauthorized.
  """
  @behaviour Plug

  import Plug.Conn

  alias Idp.Users
  alias IdpWeb.Guardian

  def init(opts), do: opts

  def call(conn, _) do
    Absinthe.Plug.put_options(conn, context: build_context(conn))
  end

  defp build_context(conn) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
         {:ok, user} <- authorize(token) do
      %{user: user, token: token}
    else
      # In case if no token found and no headers set
      # we just return empty context.
      _ -> %{}
    end
  end

  defp authorize(token) do
    case Guardian.decode_and_verify(token) do
      {:ok, %{"sub" => user_id}} ->
        {:ok, Users.get_user!(user_id)}

      {:error, _} ->
        {:error, :invalid_token}
    end
  end
end
