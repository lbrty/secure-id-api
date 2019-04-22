defmodule IdpWeb.TestUtils do
  alias Plug.Conn
  alias Idp.Users

  def get_authenticated_conn(conn, user \\ Users.get_by_email("user1@email.com"))

  def get_authenticated_conn(conn, user) do
    {:ok, token, _} = IdpWeb.Guardian.encode_and_sign(user)

    conn
    |> Conn.put_req_header("accept", "application/json")
    |> Conn.put_req_header("authorization", "Bearer #{token}")
  end
end
