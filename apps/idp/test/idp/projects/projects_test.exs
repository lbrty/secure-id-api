defmodule Idp.ProjectsTest do
  use Idp.IdpCase

  alias Idp.{Projects, Users}
  alias Idp.Projects.Project

  describe "🚀 projects ::" do
    test "list_projects/0 returns all projects" do
      assert length(Projects.list_projects()) > 0
    end

    test "get_project/1 returns the project with given id" do
      project =
        Projects.list_projects()
        |> hd()

      assert Projects.get_project(project.id) == project
    end

    test "create_project/1 with valid data creates a project" do
      attrs = %{
        name: "Projext C",
        description: "Desc"
      }
      assert {:ok, %Project{} = project} = Projects.create_project(attrs)
      assert project.description == "Desc"
      assert project.name == "Projext C"
    end

    test "create_project/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Projects.create_project(%{name: nil})
    end

    test "update_project/2 with valid data updates the project" do
      project =
        Projects.list_projects()
        |> hd()

      attrs = %{name: "XYZ", description: "ZYX"}
      assert {:ok, %Project{} = project} = Projects.update_project(project, attrs)
      assert project.description == "ZYX"
      assert project.name == "XYZ"
    end

    test "update_project/2 with invalid data returns error changeset" do
      project =
        Projects.list_projects()
        |> hd()

      attrs = %{name: nil}
      assert {:error, %Ecto.Changeset{}} = Projects.update_project(project, attrs)
    end

    test "delete_project/1 deletes the project" do
      project =
        Projects.list_projects()
        |> hd()

      assert {:ok, %Project{}} = Projects.delete_project(project)
      refute Projects.get_project(project.id)
    end

    test "change_project/1 returns a project changeset" do
      project =
        Projects.list_projects()
        |> hd()

      assert %Ecto.Changeset{} = Projects.change_project(project)
    end

    test "list_for_user/1 returns shared projects for user" do
      user =
        "user1@email.com"
        |> Users.get_by_email()

      assert length(Projects.list_for_user(user)) == 1
    end

    test "list_for_user/1 returns all projects for admins" do
      user =
        "admin@email.com"
        |> Users.get_by_email()

      assert length(Projects.list_for_user(user)) == length(Projects.list_projects())
    end
  end
end
