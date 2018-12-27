defmodule IdpApiWeb.Context do
  @behaviour Plug

  import Plug.Conn
  alias Core.{Repo, UserActions}
  alias IdpApi.Guardian

  def init(opts), do: opts

  def call(conn, _) do
    case build_context(conn) do
      {:ok, context} ->
        Absinthe.Plug.put_options(conn, context: context)

      _ ->
        conn
    end
  end

  defp build_context(conn) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
         {:ok, current_user} <- authorize(token) do

      {:ok, %{current_user: current_user, token: token}}

    else
      # In case if no token found and no headers set
      # we just return empty context.
      _ -> %{}
    end
  end

  defp authorize(token) do
    case Guardian.decode_and_verify(token) do
      {:ok, %{"sub" => user_id}} ->
        {:ok, UserActions.get_by_id(user_id)}

      {:error, _} ->
        {:error, "Invalid token"}
    end
  end
end
