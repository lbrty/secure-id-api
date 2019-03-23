defmodule IdpWeb.LoginSchemaTest do
  use IdpWeb.ConnCase, async: true

  describe "authentication" do
    test "login authenticates user if exists", %{conn: conn} do
      mutation = """
        mutation {
          login(email: "user1@email.com", password: "12345678") {
            token
          }
        }
      """

      Confetti.Seeds.run()

      request = post(conn, "/api", %{query: mutation})
      result = json_response(request, 200)
      assert result["data"]["login"]["token"] != nil
    end

    test "login returns errors if credentials are wrong", %{conn: conn} do
      mutation = """
        mutation {
          login(email: "user1@email.com", password: "12345670") {
            token
          }
        }
      """

      Confetti.Seeds.run()

      request = post(conn, "/api", %{query: mutation})
      result = json_response(request, 200)
      assert result == %{
        "data" => %{"login" => nil},
        "errors" => [
          %{
            "locations" => [%{"column" => 0, "line" => 2}],
            "path" => ["login"],
            "message" => "invalid_credentials"
          }
        ]
      }
    end

    test "login returns error if user doesn't exist", %{conn: conn} do
      mutation = """
        mutation {
          login(email: "stranger@email.com", password: "12345678") {
            token
          }
        }
      """

      request = post(conn, "/api", %{query: mutation})
      result = json_response(request, 200)
      assert result == %{
        "data" => %{"login" => nil},
        "errors" => [
          %{
            "locations" => [%{"column" => 0, "line" => 2}],
            "message" => "user_not_found",
            "path" => ["login"]
          }
        ]
      }
    end
  end
end
