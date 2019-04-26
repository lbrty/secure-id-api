defmodule IdpWeb.CountriesSchemaTest do
  use IdpWeb.WebCase

  alias Idp.Users
  alias Idp.Geo.Countries
  alias IdpWeb.TestUtils

  @moduletag :countries

  describe "🗽 countries ::" do
    test "users can request countries", %{conn: conn} do
      query = %{
        query: """
        {
          countries {
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
          "countries" => [
            %{"name" => "Germany"},
            %{"name" => "Kyrgyzstan"}
          ]
        }
      }
    end

    test "users can not create countries", %{conn: conn} do
      mutation = %{
        query: """
        mutation {
          createCountry(name: "West Britannia") {
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
        "data" => %{"createCountry" => nil},
        "errors" => [
          %{
            "code" => "permission_denied",
            "locations" => [%{"column" => 0, "line" => 2}],
            "message" => "Permission denied",
            "path" => ["createCountry"]
          }
        ]
      }
    end

    test "admins can create countries", %{conn: conn} do
      mutation = %{
        query: """
        mutation {
          createCountry(name: "West Britannia") {
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
          "createCountry" => %{"name" => "West Britannia"}
        }
      }
    end

    test "impossible to create duplicate country", %{conn: conn} do
      mutation = %{
        query: """
        mutation {
          createCountry(name: "Germany") {
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
        "data" => %{"createCountry" => nil},
        "errors" => [
          %{
            "code" => "schema_errors",
            "errors" => %{"name" => "has already been taken"},
            "locations" => [%{"column" => 0, "line" => 2}],
            "message" => "Changeset errors occurred",
            "path" => ["createCountry"]
          }
        ]
      }
    end

    test "filtering for unknown country returns empty result", %{conn: conn} do
      query = %{
        query: """
        {
          countries(name: "unknown") {
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
          "countries" => []
        }
      }
    end

    test "anonymous users can not request countries", %{conn: conn} do
      query = %{
        query: """
        {
          countries {
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
        "data" => %{"countries" => nil},
        "errors" => [
          %{
            "code" => "permission_denied",
            "locations" => [%{"column" => 0, "line" => 2}],
            "message" => "Permission denied",
            "path" => ["countries"]
          }
        ]
      }
    end

    test "users can filter countries by name", %{conn: conn} do
      query = %{
        query: """
        {
          countries(name: "Ger") {
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
          "countries" => [
            %{"name" => "Germany"}
          ]
        }
      }

      query = %{
        query: """
        {
          countries(name: "Kyrgyz") {
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
          "countries" => [
            %{"name" => "Kyrgyzstan"}
          ]
        }
      }
    end

    test "users can not update country", %{conn: conn} do
      country =
        Countries.list_countries()
        |> hd()

      mutation = %{
        query: """
        mutation {
          updateCountry(country_id: #{country.id}, name: "Update country") {
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
        "data" => %{"updateCountry" => nil},
        "errors" => [
          %{
            "code" => "permission_denied",
            "locations" => [%{"column" => 0, "line" => 2}],
            "message" => "Permission denied",
            "path" => ["updateCountry"]
          }
        ]
      }
    end

    test "admins can update country", %{conn: conn} do
      country =
        Countries.list_countries()
        |> hd()

      mutation = %{
        query: """
        mutation {
          updateCountry(country_id: #{country.id}, name: "Update country") {
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
          "updateCountry" => %{"name" => "Update country"}
        }
      }
    end

    test "update validations work", %{conn: conn} do
      country =
        Countries.list_countries()
        |> hd()

      mutation = %{
        query: """
        mutation {
          updateCountry(country_id: #{country.id}, name: "up") {
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
        "data" => %{"updateCountry" => nil},
        "errors" => [
          %{
            "code" => "schema_errors",
            "errors" => %{"name" => "should be at least 3 character(s)"},
            "locations" => [%{"column" => 0, "line" => 2}],
            "message" => "Changeset errors occurred",
            "path" => ["updateCountry"]
          }
        ]
      }
    end

    test "create validations work", %{conn: conn} do
      mutation = %{
        query: """
        mutation {
          createCountry(name: "xy") {
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
        "data" => %{"createCountry" => nil},
        "errors" => [
          %{
            "code" => "schema_errors",
            "errors" => %{"name" => "should be at least 3 character(s)"},
            "locations" => [%{"column" => 0, "line" => 2}],
            "message" => "Changeset errors occurred",
            "path" => ["createCountry"]
          }
        ]
      }
    end

    test "users can not delete country", %{conn: conn} do
      country =
        Countries.list_countries()
        |> hd()

      mutation = %{
        query: """
        mutation {
          deleteCountry(country_id: #{country.id}) {
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
        "data" => %{"deleteCountry" => nil},
        "errors" => [
          %{
            "code" => "permission_denied",
            "locations" => [%{"column" => 0, "line" => 2}],
            "message" => "Permission denied",
            "path" => ["deleteCountry"]
          }
        ]
      }
    end

    test "admins can delete country", %{conn: conn} do
      country =
        Countries.list_countries()
        |> hd()

      mutation = %{
        query: """
        mutation {
          deleteCountry(country_id: #{country.id}) {
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
          "deleteCountry" => %{"name" => country.name}
        }
      }
    end

    test "admins can not update non existent country", %{conn: conn} do
      mutation = %{
        query: """
        mutation {
          updateCountry(country_id: 123, name: "XXX") {
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
        "data" => %{"updateCountry" => nil},
        "errors" => [
          %{
            "code" => "not_found",
            "locations" => [%{"column" => 0, "line" => 2}],
            "message" => "Not found",
            "path" => ["updateCountry"]
          }
        ]
      }
    end

    test "admins can not delete non existent country", %{conn: conn} do
      mutation = %{
        query: """
        mutation {
          deleteCountry(country_id: 123) {
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
        "data" => %{"deleteCountry" => nil},
        "errors" => [
          %{
            "code" => "not_found",
            "locations" => [%{"column" => 0, "line" => 2}],
            "message" => "Not found",
            "path" => ["deleteCountry"]
          }
        ]
      }
    end
  end
end
