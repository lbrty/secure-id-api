defmodule IdpWeb.RegistrationSchemaTest do
  use IdpWeb.ConnCase, async: true

  @moduletag :registration

  setup context do
    Idp.Seeds.run()
    {:ok, context}
  end

  describe "🎭 registration ::" do
    test "can not register a new user if same email exists", %{conn: conn} do
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
