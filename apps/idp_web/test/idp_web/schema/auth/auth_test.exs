defmodule IdpWeb.AuthSchemaTest do
  use IdpWeb.ConnCase, async: true

  @moduletag :auth

  setup context do
    Idp.Seeds.run()
    {:ok, context}
  end

  describe "🔐 authentication ::" do
    test "login authenticates user if exists", %{conn: conn} do
      mutation = %{
        query: """
        mutation {
          login(email: "user1@email.com", password: "12345678") {
            token
          }
        }
        """
      }

      result =
        conn
        |> post("/api", mutation)
        |> json_response(200)

      assert result["data"]["login"]["token"] != nil
    end

    test "login returns error if credentials are wrong", %{conn: conn} do
      mutation = %{
        query: """
        mutation {
          login(email: "user1@email.com", password: "12345670") {
            token
          }
        }
        """
      }

      result =
        conn
        |> post("/api", mutation)
        |> json_response(200)

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

    test "login returns error if user does not exist", %{conn: conn} do
      mutation = %{
        query: """
        mutation {
          login(email: "stranger@email.com", password: "12345678") {
            token
          }
        }
        """
      }

      result =
        conn
        |> post("/api", mutation)
        |> json_response(200)

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

    test "login returns error if user is inactive", %{conn: conn} do
      mutation = %{
        query: """
        mutation {
          login(email: "inactive@email.com", password: "12345678") {
            token
          }
        }
        """
      }

      result =
        conn
        |> post("/api/graphql", mutation)
        |> json_response(200)

      assert result == %{
        "data" => %{"login" => nil},
        "errors" => [
          %{
            "code" => "user_not_active",
            "locations" => [%{"column" => 0, "line" => 2}],
            "message" => "User is not active",
            "path" => ["login"]
          }
        ]
      }
    end
  end
end