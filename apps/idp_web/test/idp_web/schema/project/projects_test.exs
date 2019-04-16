defmodule IdpWeb.ProjectsSchemaTest do
  use IdpWeb.ConnCase, async: true
  use ExUnit.Case

  alias Idp.Users
  alias IdpWeb.TestUtils

  setup context do
    Idp.Seeds.run()
    {:ok, context}
  end

  describe "💼 projects ::" do
    test "admin users can create projects", %{conn: conn} do
      query = """
        mutation {
          createProject(name: "🚀 project", description: "✨ Description") {
            name
            description
          }
        }
      """

      result =
        conn
        |> TestUtils.get_authenticated_conn(Users.get_by_email("admin@email.com"))
        |> post("/api/graphql", %{query: query})
        |> json_response(200)

      assert result == %{
        "data" => %{
          "createProject" => %{
            "description" => "✨ Description",
            "name" => "🚀 project"
          }
        }
      }
    end

    test "only admin users can see all projects", %{conn: conn} do
      query = """
        {
          projects {
            name
          }
        }
      """

      result =
        conn
        |> TestUtils.get_authenticated_conn(Users.get_by_email("admin@email.com"))
        |> post("/api/graphql", %{query: query})
        |> json_response(200)

      assert result == %{
        "data" => %{
          "projects" => [
            %{"name" => "Project X"},
            %{"name" => "Project Y"},
            %{"name" => "Project Z"},
            %{"name" => "Project A"}
          ]
        }
      }
    end

    # test "only admin users can edit projects", %{conn: conn} do
    # end

    # test "only admin users can delete projects", %{conn: conn} do
    # end

    # test "only users can see shared projects", %{conn: conn} do
    # end

    test "regular users can not create project", %{conn: conn} do
      query = """
        mutation {
          createProject(name: "🚀 project", description: "✨ Description") {
            name
            description
          }
        }
      """

      result =
        conn
        |> TestUtils.get_authenticated_conn()
        |> post("/api/graphql", %{query: query})
        |> json_response(200)

      assert result == %{
        "data" => %{"createProject" => nil},
        "errors" => [
          %{
            "code" => "permission_denied",
            "locations" => [%{"column" => 0, "line" => 2}],
            "message" => "Permission denied",
            "path" => ["createProject"]
          }
        ]
      }
    end

    # test "regular users can not update project", %{conn: conn} do
    # end

    # test "regular users can not delete project", %{conn: conn} do
    # end

    # test "inactive users can not performs any actions", %{conn: conn} do
    # end

    # test "anonymous users can not see any project", %{conn: conn} do
    # end
  end
end
