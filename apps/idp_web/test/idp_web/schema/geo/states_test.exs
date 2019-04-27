defmodule IdpWeb.StatesSchemaTest do
  use IdpWeb.WebCase

  alias Idp.Users
  alias Idp.Geo.{Countries, States}
  alias IdpWeb.TestUtils

  @moduletag :states

  # added additional space because this
  # emoji swallows a space in fron of it.
  describe "⛩  states ::" do
    test "users can request states", %{conn: conn} do
      query = %{
        query: """
        {
          states {
            name
          }
        }
        """
      }

      result =
        conn
        |> TestUtils.get_authenticated_conn()
        |> post("/api", query)
        |> json_response(200)

      assert result == %{
        "data" => %{
          "states" => [
            %{"name" => "Berlin"},
            %{"name" => "Chuy"}
          ]
        }
      }
    end

    test "users can not create state", %{conn: conn} do
      mutation = %{
        query: """
        mutation {
          createState(name: "SpaceX", country_id: 123) {
            name
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
        "data" => %{"createState" => nil},
        "errors" => [
          %{
            "code" => "permission_denied",
            "locations" => [%{"column" => 0, "line" => 2}],
            "message" => "Permission denied",
            "path" => ["createState"]
          }
        ]
      }
    end

    test "admins can create new states", %{conn: conn} do
      country =
        Countries.list_countries()
        |> hd()

      mutation = %{
        query: """
        mutation {
          createState(name: "SpaceX", country_id: #{country.id}) {
            name

            country {
              id
            }
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
          "createState" => %{
            "name" => "SpaceX",
            "country" => %{
              "id" => "#{country.id}"
            }
          }
        }
      }
    end

    test "filtering for unknown state returns empty result", %{conn: conn} do
      query = %{
        query: """
        {
          states(name: "unknown") {
            name
          }
        }
        """
      }

      result =
        conn
        |> TestUtils.get_authenticated_conn()
        |> post("/api", query)
        |> json_response(200)

      assert result == %{
        "data" => %{
          "states" => []
        }
      }
    end

    test "anonymous users can not request states", %{conn: conn} do
      query = %{
        query: """
        {
          states {
            name
          }
        }
        """
      }

      result =
        conn
        |> post("/api", query)
        |> json_response(200)

      assert result == %{
        "data" => %{"states" => nil},
        "errors" => [
          %{
            "code" => "permission_denied",
            "locations" => [%{"column" => 0, "line" => 2}],
            "message" => "Permission denied",
            "path" => ["states"]
          }
        ]
      }
    end

    test "users can filter states by name", %{conn: conn} do
      query = %{
        query: """
        {
          states(name: "ch") {
            name
          }
        }
        """
      }

      result =
        conn
        |> TestUtils.get_authenticated_conn()
        |> post("/api", query)
        |> json_response(200)

      assert result == %{
        "data" => %{
          "states" => [
            %{"name" => "Chuy"}
          ]
        }
      }

      query = %{
        query: """
        {
          states(name: "Ber") {
            name
          }
        }
        """
      }

      result =
        conn
        |> TestUtils.get_authenticated_conn()
        |> post("/api", query)
        |> json_response(200)

      assert result == %{
        "data" => %{
          "states" => [
            %{"name" => "Berlin"}
          ]
        }
      }
    end

    test "users can not update state", %{conn: conn} do
      state =
        States.list_states()
        |> hd()

      mutation = %{
        query: """
        mutation {
          updateState(state_id: #{state.id}, name: "Update state") {
            name
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
        "data" => %{"updateState" => nil},
        "errors" => [
          %{
            "code" => "permission_denied",
            "locations" => [%{"column" => 0, "line" => 2}],
            "message" => "Permission denied",
            "path" => ["updateState"]
          }
        ]
      }
    end

    test "admins can update state", %{conn: conn} do
      state =
        States.list_states()
        |> hd()

      mutation = %{
        query: """
        mutation {
          updateState(state_id: #{state.id}, name: "Update state") {
            name
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
          "updateState" => %{"name" => "Update state"}
        }
      }
    end

    test "it is possible to get country of state", %{conn: conn} do
      query = %{
        query: """
        {
          states {
            name

            country {
              name
            }
          }
        }
        """
      }

      result =
        conn
        |> TestUtils.get_authenticated_conn()
        |> post("/api", query)
        |> json_response(200)

      assert result == %{
        "data" => %{
          "states" => [
            %{"country" => %{"name" => "Germany"}, "name" => "Berlin"},
            %{"country" => %{"name" => "Kyrgyzstan"}, "name" => "Chuy"}
          ]
        }
      }
    end

    test "it is possible to get cities of state", %{conn: conn} do
      query = %{
        query: """
        {
          states {
            name

            cities {
              name
            }
          }
        }
        """
      }

      result =
        conn
        |> TestUtils.get_authenticated_conn()
        |> post("/api", query)
        |> json_response(200)

      assert result == %{
        "data" => %{
          "states" => [
            %{"cities" => [%{"name" => "Berlin"}], "name" => "Berlin"},
            %{"cities" => [%{"name" => "Bishkek"}], "name" => "Chuy"}
          ]
        }
      }
    end

    test "update validations work", %{conn: conn} do
      state =
        States.list_states()
        |> hd()

      mutation = %{
        query: """
        mutation {
          updateState(state_id: #{state.id}, name: "up") {
            name
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
        "data" => %{"updateState" => nil},
        "errors" => [
          %{
            "code" => "schema_errors",
            "errors" => %{"name" => "should be at least 3 character(s)"},
            "locations" => [%{"column" => 0, "line" => 2}],
            "message" => "Changeset errors occurred",
            "path" => ["updateState"]
          }
        ]
      }
    end

    test "create state validations work", %{conn: conn} do
      country =
        Countries.list_countries()
        |> hd()

      mutation = %{
        query: """
        mutation {
          createState(name: "xy", country_id: #{country.id}) {
            name
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
        "data" => %{"createState" => nil},
        "errors" => [
          %{
            "code" => "schema_errors",
            "errors" => %{"name" => "should be at least 3 character(s)"},
            "locations" => [%{"column" => 0, "line" => 2}],
            "message" => "Changeset errors occurred",
            "path" => ["createState"]
          }
        ]
      }
    end

    test "users can not delete state", %{conn: conn} do
      state =
        States.list_states()
        |> hd()

      mutation = %{
        query: """
        mutation {
          deleteState(state_id: #{state.id}) {
            name
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
        "data" => %{"deleteState" => nil},
        "errors" => [
          %{
            "code" => "permission_denied",
            "locations" => [%{"column" => 0, "line" => 2}],
            "message" => "Permission denied",
            "path" => ["deleteState"]
          }
        ]
      }
    end

    test "admins can delete state", %{conn: conn} do
      state =
        States.list_states()
        |> hd()

      mutation = %{
        query: """
        mutation {
          deleteState(state_id: #{state.id}) {
            name
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
          "deleteState" => %{"name" => state.name}
        }
      }
    end

    test "admins can not update non existent state", %{conn: conn} do
      mutation = %{
        query: """
        mutation {
          updateState(state_id: 123, name: "XXX") {
            name
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
        "data" => %{"updateState" => nil},
        "errors" => [
          %{
            "code" => "not_found",
            "locations" => [%{"column" => 0, "line" => 2}],
            "message" => "Not found",
            "path" => ["updateState"]
          }
        ]
      }
    end

    test "admins can not delete non existent state", %{conn: conn} do
      mutation = %{
        query: """
        mutation {
          deleteState(state_id: 123) {
            name
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
        "data" => %{"deleteState" => nil},
        "errors" => [
          %{
            "code" => "not_found",
            "locations" => [%{"column" => 0, "line" => 2}],
            "message" => "Not found",
            "path" => ["deleteState"]
          }
        ]
      }
    end
  end
end
