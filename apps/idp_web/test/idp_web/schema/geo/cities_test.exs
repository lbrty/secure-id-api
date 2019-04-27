defmodule IdpWeb.CitiesSchemaTest do
  use IdpWeb.WebCase

  alias Idp.Users
  alias Idp.Geo.{Cities, States}
  alias IdpWeb.TestUtils

  @moduletag :cities

  describe "🏰 cities ::" do
    test "users can request cities", %{conn: conn} do
      query = %{
        query: """
        {
          cities {
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
          "cities" => [
            %{"name" => "Berlin"},
            %{"name" => "Bishkek"}
          ]
        }
      }
    end

    test "users can not create cities", %{conn: conn} do
      mutation = %{
        query: """
        mutation {
          createCity(name: "City Y", state_id: 123) {
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
        "data" => %{"createCity" => nil},
        "errors" => [
          %{
            "code" => "permission_denied",
            "locations" => [%{"column" => 0, "line" => 2}],
            "message" => "Permission denied",
            "path" => ["createCity"]
          }
        ]
      }
    end

    test "admins can create a new city", %{conn: conn} do
      state =
        States.list_states()
        |> hd()

      mutation = %{
        query: """
        mutation {
          createCity(name: "City Y", state_id: #{state.id}) {
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
          "createCity" => %{"name" => "City Y"}
        }
      }
    end

    test "filtering for unknown city returns empty result", %{conn: conn} do
      query = %{
        query: """
        {
          cities(name: "unknown") {
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
          "cities" => []
        }
      }
    end

    test "anonymous users can not request cities", %{conn: conn} do
      query = %{
        query: """
        {
          cities {
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
        "data" => %{"cities" => nil},
        "errors" => [
          %{
            "code" => "permission_denied",
            "locations" => [%{"column" => 0, "line" => 2}],
            "message" => "Permission denied",
            "path" => ["cities"]
          }
        ]
      }
    end

    test "users can filter cities by name", %{conn: conn} do
      query = %{
        query: """
        {
          cities(name: "bish") {
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
          "cities" => [
            %{"name" => "Bishkek"}
          ]
        }
      }

      query = %{
        query: """
        {
          cities(name: "berl") {
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
          "cities" => [
            %{"name" => "Berlin"}
          ]
        }
      }
    end

    test "users can not update city", %{conn: conn} do
      city =
        Cities.list_cities()
        |> hd()

      mutation = %{
        query: """
        mutation {
          updateCity(city_id: #{city.id}, name: "Update city") {
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
        "data" => %{"updateCity" => nil},
        "errors" => [
          %{
            "code" => "permission_denied",
            "locations" => [%{"column" => 0, "line" => 2}],
            "message" => "Permission denied",
            "path" => ["updateCity"]
          }
        ]
      }
    end

    test "admins can update city", %{conn: conn} do
      city =
        Cities.list_cities()
        |> hd()

      mutation = %{
        query: """
        mutation {
          updateCity(city_id: #{city.id}, name: "Update city") {
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
          "updateCity" => %{"name" => "Update city"}
        }
      }
    end

    test "it is possible to get state and country for cities", %{conn: conn} do
      query = %{
        query: """
        {
          cities {
            name

            state {
              name

              country {
                name
              }
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
          "cities" => [
            %{
              "name" => "Berlin",
              "state" => %{"country" => %{"name" => "Germany"}, "name" => "Berlin"}
            },
            %{
              "name" => "Bishkek",
              "state" => %{"country" => %{"name" => "Kyrgyzstan"}, "name" => "Chuy"}
            }
          ]
        }
      }
    end

    test "update validations work", %{conn: conn} do
      city =
        Cities.list_cities()
        |> hd()

      mutation = %{
        query: """
        mutation {
          updateCity(city_id: #{city.id}, name: "up") {
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
        "data" => %{"updateCity" => nil},
        "errors" => [
          %{
            "code" => "schema_errors",
            "errors" => %{"name" => "should be at least 3 character(s)"},
            "locations" => [%{"column" => 0, "line" => 2}],
            "message" => "Changeset errors occurred",
            "path" => ["updateCity"]
          }
        ]
      }
    end

    test "create validations work", %{conn: conn} do
      mutation = %{
        query: """
        mutation {
          createCity(name: "xy", state_id: 213) {
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
        "data" => %{"createCity" => nil},
        "errors" => [
          %{
            "code" => "schema_errors",
            "errors" => %{"name" => "should be at least 3 character(s)"},
            "locations" => [%{"column" => 0, "line" => 2}],
            "message" => "Changeset errors occurred",
            "path" => ["createCity"]
          }
        ]
      }
    end

    test "users can not delete city", %{conn: conn} do
      city =
        Cities.list_cities()
        |> hd()

      mutation = %{
        query: """
        mutation {
          deleteCity(city_id: #{city.id}) {
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
        "data" => %{"deleteCity" => nil},
        "errors" => [
          %{
            "code" => "permission_denied",
            "locations" => [%{"column" => 0, "line" => 2}],
            "message" => "Permission denied",
            "path" => ["deleteCity"]
          }
        ]
      }
    end

    test "admins can delete city", %{conn: conn} do
      city =
        Cities.list_cities()
        |> hd()

      mutation = %{
        query: """
        mutation {
          deleteCity(city_id: #{city.id}) {
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
          "deleteCity" => %{"name" => city.name}
        }
      }
    end

    test "admins can not update non existent city", %{conn: conn} do
      mutation = %{
        query: """
        mutation {
          updateCity(city_id: 123, name: "XXX") {
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
        "data" => %{"updateCity" => nil},
        "errors" => [
          %{
            "code" => "not_found",
            "locations" => [%{"column" => 0, "line" => 2}],
            "message" => "Not found",
            "path" => ["updateCity"]
          }
        ]
      }
    end

    test "admins can not delete non existent city", %{conn: conn} do
      mutation = %{
        query: """
        mutation {
          deleteCity(city_id: 123) {
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
        "data" => %{"deleteCity" => nil},
        "errors" => [
          %{
            "code" => "not_found",
            "locations" => [%{"column" => 0, "line" => 2}],
            "message" => "Not found",
            "path" => ["deleteCity"]
          }
        ]
      }
    end
  end
end
