defmodule IdpWeb.UserSchemaTest do
  use IdpWeb.WebCase

  alias Idp.Users
  alias IdpWeb.TestUtils

  @moduletag :users

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

    test "admins can update any user", %{conn: conn} do
      user = Users.get_by_email("user1@email.com")
      mutation = %{
        query: """
        mutation {
          updateUser(
            user_id: #{user.id},
            fields: {
              email: "user1@example.com",
              full_name: "Full name User 1",
              is_active: true,
              is_superuser: false
            }
          ) {
            email
            full_name
            is_active
            is_superuser
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
          "updateUser" => %{
            "email" => "user1@example.com",
            "full_name" => "Full name User 1",
            "is_active" => true,
            "is_superuser" => false
          }
        }
      }
    end

    test "admins can update passwords for other users", %{conn: conn} do
      # Change password for `user1@email.com`.
      # Then try to authenticate w/ new password.
      user = Users.get_by_email("user1@email.com")
      mutation = %{
        query: """
        mutation {
          forceChangePassword(
            user_id: #{user.id},
            passwords: {
              new_password: "012345678"
              new_password_confirmation: "012345678"
            }
          ) {
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
          "forceChangePassword" => %{
            "email" => "user1@email.com"
          }
        }
      }

      # Now check if we can authenticate the user with new password
      mutation = %{
        query: """
        mutation {
          login(email: "user1@email.com", password: "012345678") {
            token
          }
        }
        """
      }

      result =
        conn
        |> post("/api", mutation)
        |> json_response(200)

      assert get_in(result, ["data", "login", "token"])
    end

    test "admin update password validation works", %{conn: conn} do
      user = Users.get_by_email("user1@email.com")
      mutation = %{
        query: """
        mutation {
          forceChangePassword(
            user_id: #{user.id},
            passwords: {
              new_password: "012345678"
              new_password_confirmation: "01234567"
            }
          ) {
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
        "data" => %{"forceChangePassword" => nil},
        "errors" => [
          %{
            "code" => "schema_errors",
            "errors" => %{"new_password_confirmation" => "Passwords do not match"},
            "locations" => [%{"column" => 0, "line" => 2}],
            "message" => "Changeset errors occurred",
            "path" => ["forceChangePassword"]
          }
        ]
      }
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
      user = Users.get_by_email("user1@email.com")
      mutation = %{
        query: """
        mutation {
          updateUser(
            user_id: #{user.id},
            fields: {
              email: "user1@example.com",
              full_name: "Full name User 1",
              is_active: true,
              is_superuser: false
            }
          ) {
            email
            full_name
            is_active
            is_superuser
          }
        }
        """
      }

      result =
        conn
        |> TestUtils.get_authenticated_conn(user)
        |> post("/api", mutation)
        |> json_response(200)

      assert result == %{
        "data" => %{
          "updateUser" => %{
            "email" => "user1@example.com",
            "full_name" => "Full name User 1",
            "is_active" => true,
            "is_superuser" => false
          }
        }
      }
    end

    test "users can abandon shared projects", %{conn: conn} do
    end

    test "users can update their passwords", %{conn: conn} do
    end

    test "users can not update other user records", %{conn: conn} do
    end
  end
end
