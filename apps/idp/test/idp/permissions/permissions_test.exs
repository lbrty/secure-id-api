defmodule Idp.PermissionsTest do
  use Idp.IdpCase

  alias Idp.{Permissions, Projects, Users}
  alias Idp.Permissions.Permission

  @valid_attrs %{
    can_create: true,
    can_delete: true,
    can_read: true,
    can_update: true,
    view_contacts: true,
    view_documents: true,
    view_personal: true,
    user_id: nil,
    project_id: nil
  }

  describe "[🚨] permissions ::" do
    test "list_permissions/0 returns all permissions" do
      assert length(Permissions.list_permissions()) > 0
    end

    test "get_permission/1 returns the permission with given id" do
      permission =
        Permissions.list_permissions()
        |> hd()

      assert Permissions.get_permission(permission.id) == permission
    end

    test "create_permission/1 with valid data creates a permission" do
      valid_attrs = get_valid_attrs()
      assert {:ok, %Permission{} = permission} = Permissions.create_permission(valid_attrs)
      assert permission.can_create == true
      assert permission.can_delete == true
      assert permission.can_read == true
      assert permission.can_update == true
      assert permission.view_contacts == true
      assert permission.view_documents == true
      assert permission.view_personal == true
      assert permission.user_id == valid_attrs[:user_id]
      assert permission.project_id == valid_attrs[:project_id]
    end

    test "create_permission/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Permissions.create_permission(%{can_create: true})
    end

    test "update_permission/2 with valid data updates the permission" do
      valid_attrs = %{get_valid_attrs() | can_create: false, can_delete: false}
      permission = Permissions.list_permissions() |> hd()

      assert {:ok, %Permission{} = permission} =
              Permissions.update_permission(permission, valid_attrs)

      assert permission.can_create == false
      assert permission.can_delete == false
    end

    test "update_permission/2 with invalid data returns error changeset" do
      permission = Permissions.list_permissions() |> hd()

      assert {:error, %Ecto.Changeset{}} =
               Permissions.update_permission(permission, %{user_id: nil})

      assert permission == Permissions.get_permission(permission.id)
    end

    test "delete_permission/1 deletes the permission" do
      permission = Permissions.list_permissions() |> hd()
      assert {:ok, %Permission{}} = Permissions.delete_permission(permission)
      refute Permissions.get_permission(permission.id)
    end

    test "change_permission/1 returns a permission changeset" do
      permission = Permissions.list_permissions() |> hd()
      assert %Ecto.Changeset{} = Permissions.change_permission(permission)
    end

    test "list_for_user/1 returns a list permissions" do
      permissions =
        "user1@email.com"
        |> Users.get_by_email()
        |> Permissions.list_for_user()

      assert length(permissions) == 1
    end

    test "for_project_and_user/2 returns the permission" do
      permission = Permissions.list_permissions() |> hd()
      user =
        permission.user_id
        |> Users.get_user()

      project =
        permission.project_id
        |> Projects.get_project()

      found =
        project
        |> Permissions.for_project_and_user(user)

      assert permission == found
    end
  end

  defp get_valid_attrs do
    user = Users.get_by_email("user1@email.com")
    project = Projects.list_projects() |> hd()

    %{@valid_attrs | user_id: user.id, project_id: project.id}
  end
end
