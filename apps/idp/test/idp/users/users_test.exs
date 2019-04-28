defmodule Idp.UsersTest do
  use Idp.IdpCase

  alias Idp.Users
  alias Idp.Users.User

  describe "[🦄] users ::" do
    alias Idp.Users.User

    @valid_attrs %{
      email: "some@email.com",
      full_name: "some full_name",
      is_active: true,
      is_superuser: true,
      password: "12345678",
      password_hash: "some password_hash"
    }

    test "list_users/0 returns all users" do
      assert length(Users.list_users()) > 0
    end

    test "get_user/1 returns the user with given id" do
      user =
        Users.list_users()
        |> hd()

      assert Users.get_user(user.id) == user
    end

    test "register_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Users.register_user(@valid_attrs)
      assert user.email == "some@email.com"
      assert user.full_name == "some full_name"
      assert user.is_active == true
      assert user.is_superuser == true
      assert user.password_hash
    end

    test "register_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Users.register_user(%{})
    end

    test "update_user/2 with valid data updates the user" do
      user =
        "user1@email.com"
        |> Users.get_by_email()

      attrs = %{full_name: "xbobo"}
      assert {:ok, %User{} = user} = Users.update_user(user, attrs)
      assert user.full_name == "xbobo"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user =
        "user1@email.com"
        |> Users.get_by_email()

      assert {:error, %Ecto.Changeset{}} = Users.update_user(user, %{email: "wronk-email"})
    end

    test "delete_user/1 deletes the user" do
      user =
        Users.list_users()
        |> hd()

      assert {:ok, %User{}} = Users.delete_user(user)
      refute Users.get_user(user.id)
    end

    test "change_user/1 returns a user changeset" do
      user =
        Users.list_users()
        |> hd()

      assert %Ecto.Changeset{} = Users.change_user(user)
    end

    test "get_by_email/1 returns a user by email" do
      user =
        "user1@email.com"
        |> Users.get_by_email()

      assert user.email == "user1@email.com"
    end

    test "get_by_email/1 returns nil if the user was not found" do
      user =
        "xyz@email.com"
        |> Users.get_by_email()

      refute user
    end

    test "change_password/2 updates password for user" do
      user =
        Users.list_users()
        |> hd()

      attrs = %{
        password: "12345678",
        new_password: "23456781",
        new_password_confirmation: "23456781"
      }

      {:ok, updated_user} = Users.change_password(user, attrs)
      assert user.password_hash != updated_user.password_hash
    end

    test "force_change_password/2 updates password for user" do
      user =
        Users.list_users()
        |> hd()

      attrs = %{
        new_password: "23456781",
        new_password_confirmation: "23456781"
      }

      {:ok, updated_user} = Users.force_change_password(user, attrs)
      assert user.password_hash != updated_user.password_hash
    end
  end
end
