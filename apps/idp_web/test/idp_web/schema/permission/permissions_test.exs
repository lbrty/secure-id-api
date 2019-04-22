defmodule IdpWeb.PermissionsSchemaTest do
  use IdpWeb.WebCase

  alias IdpWeb.TestUtils

  @moduletag :permissions

  describe "🚨 permissions ::" do
    test "admins can see all permissions for project", %{conn: conn} do
    end

    test "admins can share project with user", %{conn: conn} do
    end

    test "users can abandon shared projects", %{conn: conn} do
    end

    test "users can share project with user", %{conn: conn} do
    end

    test "users can see only their own permissions", %{conn: conn} do
    end

    test "users can not see permissions for any project", %{conn: conn} do
    end
  end
end
