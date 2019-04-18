defmodule IdpWeb.UserSchemaTest do
  use ExUnit.Case
  use IdpWeb.ConnCase, async: true

  alias Idp.Users
  alias IdpWeb.TestUtils

  @moduletag :users

  setup context do
    Idp.Seeds.run()
    {:ok, context}
  end

  describe "🦄 users ::" do
    test "admins can see all existing users", %{conn: conn} do
      mutation = %{
        query: """
        {
          users {
            full_name
            email
          }
        }
        """
      }

      result =
        conn
        |> TestUtils.get_authenticated_conn(Users.get_by_email("admin@email.com"))
        |> post("/api", mutation)
        |> json_response(200)

      assert result == %{
        "data" => %{
          "users" => [
            %{"email" => "admin@email.com", "full_name" => "Admin"},
            %{"email" => "user1@email.com", "full_name" => "User 1"},
            %{"email" => "user2@email.com", "full_name" => "User 2"},
            %{"email" => "user3@email.com", "full_name" => "User 3"},
            %{"email" => "user4@email.com", "full_name" => "User 4"},
            %{"email" => "user5@email.com", "full_name" => "User 5"},
            %{"email" => "admin2@email.com", "full_name" => "User 6"},
            %{"email" => "inactive@email.com", "full_name" => "Inactive user 1"}
          ]
        }
      }
    end

    test "admins can update users", %{conn: conn} do
    end

    test "admins can update passwords for other users", %{conn: conn} do
    end

    test "admins can see shared projects for any user", %{conn: conn} do
    end

    test "admins can delete users", %{conn: conn} do
    end

    test "users can not see all existing users", %{conn: conn} do
      mutation = %{
        query: """
        {
          users {
            full_name
            email
          }
        }
        """
      }

      result =
        conn
        |> TestUtils.get_authenticated_conn()
        |> post("/api", mutation)
        |> json_response(200)

      assert result == %{
        "data" => %{"users" => nil},
        "errors" => [
          %{
            "code" => "permission_denied",
            "locations" => [%{"column" => 0, "line" => 2}],
            "message" => "Permission denied",
            "path" => ["users"]
          }
        ]
      }
    end

    test "users only see their shared projects", %{conn: conn} do
    end

    test "users can update their user records", %{conn: conn} do
    end

    test "users can abandon shared projects", %{conn: conn} do
    end

    test "users can update their passwords", %{conn: conn} do
    end

    test "users can update other user records", %{conn: conn} do
    end
  end
end
