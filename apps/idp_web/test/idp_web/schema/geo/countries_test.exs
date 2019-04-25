defmodule IdpWeb.CountriessSchemaTest do
  use IdpWeb.WebCase

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
  end
end
