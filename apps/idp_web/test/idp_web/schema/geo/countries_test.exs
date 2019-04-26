defmodule IdpWeb.CountriesSchemaTest do
  use IdpWeb.WebCase

  alias Idp.Users
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

    test "impossible to create duplicate countries", %{conn: conn} do
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
  end
end
