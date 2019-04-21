defmodule IdpWeb.ProjectsSchemaTest do
  use IdpWeb.WebCase

  alias Idp.Users
  alias IdpWeb.TestUtils

  @moduletag :projects

  describe "🚀 projects ::" do
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

    test "admin users can see all projects", %{conn: conn} do
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

    test "admin users can update projects", %{conn: conn} do
      admin_conn =
        conn
        |> TestUtils.get_authenticated_conn(Users.get_by_email("admin@email.com"))

      pid =
        admin_conn
        |> get_project()
        |> Map.get("id")
        |> String.to_integer()

      query = %{
        query: """
        mutation {
          updateProject(
            project_id: #{pid},
            project: {
              name: "Stars ✨ and rockets 🚀",
              description: "🌏"
            }
          ) {
            name
            description
          }
        }
        """
      }

      result =
        admin_conn
        |> post("/api/graphql", query)
        |> json_response(200)

      assert result == %{
        "data" => %{
          "updateProject" => %{
            "name" => "Stars ✨ and rockets 🚀",
            "description" => "🌏"
          }
        }
      }
    end

    test "attempt to update non existing user returns error", %{conn: conn} do
    end

    test "admin users can delete projects", %{conn: conn} do
      admin_conn =
        conn
        |> TestUtils.get_authenticated_conn(Users.get_by_email("admin@email.com"))

      pid =
        admin_conn
        |> get_project()
        |> Map.get("id")
        |> String.to_integer()

      query = %{
        query: """
        mutation {
          deleteProject(project_id: #{pid}) {
            id
          }
        }
        """
      }

      result =
        admin_conn
        |> post("/api/graphql", query)
        |> json_response(200)

      assert result == %{
        "data" => %{
          "deleteProject" => %{
            "id" => "#{pid}"
          }
        }
      }
    end

    test "users can see shared projects", %{conn: conn} do
      query = """
        {
          projects {
            name
          }
        }
      """

      # get projects for user1@email.com
      result =
        conn
        |> TestUtils.get_authenticated_conn()
        |> post("/api/graphql", %{query: query})
        |> json_response(200)

      assert result == %{
        "data" => %{
          "projects" => [
            %{"name" => "Project X"}
          ]
        }
      }
    end

    test "users can not see shared projects for other users", %{conn: conn} do
      user = Users.get_by_email("user2@email.com")
      query = """
        {
          projects(user_id: #{user.id}) {
            name
          }
        }
      """

      # get projects for user1@email.com
      result =
        conn
        |> TestUtils.get_authenticated_conn()
        |> post("/api/graphql", %{query: query})
        |> json_response(200)

      assert result == %{
        "data" => %{"projects" => nil},
        "errors" => [
          %{
            "code" => "permission_denied",
            "locations" => [%{"column" => 0, "line" => 2}],
            "message" => "Permission denied",
            "path" => ["projects"]
          }
        ]
      }
    end

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

    test "regular users can not update project", %{conn: conn} do
      admin_conn =
        conn
        |> TestUtils.get_authenticated_conn(Users.get_by_email("admin@email.com"))

      pid =
        admin_conn
        |> get_project()
        |> Map.get("id")
        |> String.to_integer()

      query = %{
        query: """
        mutation {
          updateProject(
            project_id: #{pid},
            project: {
              name: "Stars ✨ and rockets 🚀",
              description: "🌏"
            }
          ) {
            name
            description
          }
        }
        """
      }

      result =
        conn
        |> TestUtils.get_authenticated_conn()
        |> post("/api/graphql", query)
        |> json_response(200)

      assert result == %{
        "data" => %{"updateProject" => nil},
        "errors" => [
          %{
            "code" => "permission_denied",
            "locations" => [%{"column" => 0, "line" => 2}],
            "message" => "Permission denied",
            "path" => ["updateProject"]
          }
        ]
      }
    end

    test "regular users can not delete project", %{conn: conn} do
      admin_conn =
        conn
        |> TestUtils.get_authenticated_conn(Users.get_by_email("admin@email.com"))

      pid =
        admin_conn
        |> get_project()
        |> Map.get("id")
        |> String.to_integer()

      query = %{
        query: """
        mutation {
          deleteProject(project_id: #{pid}) {
            id
          }
        }
        """
      }

      result =
        conn
        |> TestUtils.get_authenticated_conn()
        |> post("/api/graphql", query)
        |> json_response(200)

      assert result == %{
        "data" => %{"deleteProject" => nil},
        "errors" => [
          %{
            "code" => "permission_denied",
            "locations" => [%{"column" => 0, "line" => 2}],
            "message" => "Permission denied",
            "path" => ["deleteProject"]
          }
        ]
      }
    end

    test "inactive users can not perform any actions", %{conn: conn} do
      query = """
        {
          projects {
            name
          }
        }
      """

      result =
        conn
        |> TestUtils.get_authenticated_conn(Users.get_by_email("inactive@email.com"))
        |> post("/api/graphql", %{query: query})
        |> json_response(200)

      assert result == %{
        "data" => %{"projects" => nil},
        "errors" => [
          %{
            "code" => "user_not_active",
            "locations" => [%{"column" => 0, "line" => 2}],
            "message" => "User is not active",
            "path" => ["projects"]
          }
        ]
      }
    end

    test "anonymous users can not see any project", %{conn: conn} do
      query = """
        {
          projects {
            name
          }
        }
      """

      result =
        conn
        |> post("/api/graphql", %{query: query})
        |> json_response(200)

      assert result == %{
        "data" => %{"projects" => nil},
        "errors" => [
          %{
            "code" => "permission_denied",
            "locations" => [%{"column" => 0, "line" => 2}],
            "message" => "Permission denied",
            "path" => ["projects"]
          }
        ]
      }
    end
  end

  defp get_project(conn) do
    query = %{
      query: """
      {
        projects {
          id
          name
        }
      }
      """
    }

    conn
    |> post("/api/graphql", query)
    |> json_response(200)
    |> Map.get("data")
    |> Map.get("projects")
    |> hd()
  end
end
