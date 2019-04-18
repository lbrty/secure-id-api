defmodule IdpWeb.RegistrationSchemaTest do
  use IdpWeb.ConnCase, async: true

  alias Idp.Users
  alias IdpWeb.TestUtils

  @moduletag :registration

  setup context do
    Idp.Seeds.run()
    {:ok, context}
  end

  describe "🎭 registration ::" do
    test "regular users can not register a new user", %{conn: conn} do
      mutation = %{
        query: """
        mutation {
          register(email: "newuser@email.com", password: "12345678", full_name: "Bla bla") {
            result
          }
        }
        """
      }

      result =
        conn
        |> post("/api/graphql", mutation)
        |> json_response(200)

      assert result == %{
        "data" => %{"register" => nil},
        "errors" => [
          %{
            "code" => "permission_denied",
            "locations" => [%{"column" => 0, "line" => 2}],
            "message" => "Permission denied",
            "path" => ["register"]
          }
        ]
      }
    end

    test "can not register a new user if input is invalid", %{conn: conn} do
      mutation = %{
        query: """
        mutation {
          register(email: "", password: "123", full_name: "Bla bla") {
            result
          }
        }
        """
      }

      result =
        conn
        |> TestUtils.get_authenticated_conn(Users.get_by_email("admin@email.com"))
        |> post("/api/graphql", mutation)
        |> json_response(200)

      assert result == %{
        "data" => %{"register" => nil},
        "errors" => [
          %{
            "code" => "schema_errors",
            "errors" => %{
              "email" => "can't be blank",
              "password" => "should be at least 8 character(s)"
            },
            "locations" => [%{"column" => 0, "line" => 2}],
            "message" => "Changeset errors occurred",
            "path" => ["register"]
          }
        ]
    end

    test "can not register a new user if user with same email already exists", %{conn: conn} do
      mutation = %{
        query: """
        mutation {
          register(email: "inactive@email.com", password: "12345678", full_name: "Bla bla") {
            result
          }
        }
        """
      }

      result =
        conn
        |> TestUtils.get_authenticated_conn(Users.get_by_email("admin@email.com"))
        |> post("/api/graphql", mutation)
        |> json_response(200)

      assert result == %{
        "data" => %{"register" => nil},
        "errors" => [
          %{
            "code" => "user_already_exists",
            "locations" => [%{"column" => 0, "line" => 2}],
            "message" => "User already exists",
            "path" => ["register"]
          }
        ]
      }
    end
  end
end
