defmodule Idp.PermissionsTest do
  use Idp.DataCase

  alias Idp.Permissions

  describe "permissions" do
    alias Idp.Permissions.Permission

    @valid_attrs %{
      can_create: true,
      can_delete: true,
      can_read: true,
      can_update: true,
      view_contacts: true,
      view_documents: true,
      view_personal: true
    }
    @update_attrs %{
      can_create: false,
      can_delete: false,
      can_read: false,
      can_update: false,
      view_contacts: false,
      view_documents: false,
      view_personal: false
    }
    @invalid_attrs %{
      can_create: nil,
      can_delete: nil,
      can_read: nil,
      can_update: nil,
      view_contacts: nil,
      view_documents: nil,
      view_personal: nil
    }

    def permission_fixture(attrs \\ %{}) do
      {:ok, permission} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Permissions.create_permission()

      permission
    end

    test "list_permissions/0 returns all permissions" do
      permission = permission_fixture()
      assert Permissions.list_permissions() == [permission]
    end

    test "get_permission!/1 returns the permission with given id" do
      permission = permission_fixture()
      assert Permissions.get_permission!(permission.id) == permission
    end

    test "create_permission/1 with valid data creates a permission" do
      assert {:ok, %Permission{} = permission} = Permissions.create_permission(@valid_attrs)
      assert permission.can_create == true
      assert permission.can_delete == true
      assert permission.can_read == true
      assert permission.can_update == true
      assert permission.view_contacts == true
      assert permission.view_documents == true
      assert permission.view_personal == true
    end

    test "create_permission/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Permissions.create_permission(@invalid_attrs)
    end

    test "update_permission/2 with valid data updates the permission" do
      permission = permission_fixture()

      assert {:ok, %Permission{} = permission} =
               Permissions.update_permission(permission, @update_attrs)

      assert permission.can_create == false
      assert permission.can_delete == false
      assert permission.can_read == false
      assert permission.can_update == false
      assert permission.view_contacts == false
      assert permission.view_documents == false
      assert permission.view_personal == false
    end

    test "update_permission/2 with invalid data returns error changeset" do
      permission = permission_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Permissions.update_permission(permission, @invalid_attrs)

      assert permission == Permissions.get_permission!(permission.id)
    end

    test "delete_permission/1 deletes the permission" do
      permission = permission_fixture()
      assert {:ok, %Permission{}} = Permissions.delete_permission(permission)
      assert_raise Ecto.NoResultsError, fn -> Permissions.get_permission!(permission.id) end
    end

    test "change_permission/1 returns a permission changeset" do
      permission = permission_fixture()
      assert %Ecto.Changeset{} = Permissions.change_permission(permission)
    end
  end
end
