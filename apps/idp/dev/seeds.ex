defmodule Idp.Seeds do
  alias Idp.Users

  def run() do
    {:ok, admin} = Users.create_user(%{email: "admin@email.com", full_name: "User 1", password: "12345678", is_superuser: true})
    {:ok, user1} = Users.create_user(%{email: "user1@email.com", full_name: "User 1", password: "12345678", is_superuser: false})
    {:ok, user2} = Users.create_user(%{email: "user2@email.com", full_name: "User 2", password: "12345678", is_superuser: false})
    {:ok, user3} = Users.create_user(%{email: "user3@email.com", full_name: "User 3", password: "12345678", is_superuser: false})
    {:ok, user4} = Users.create_user(%{email: "user4@email.com", full_name: "User 4", password: "12345678", is_superuser: false})
    {:ok, user5} = Users.create_user(%{email: "user5@email.com", full_name: "User 5", password: "12345678", is_superuser: false})

    Users.create_user(%{email: "admin2@email.com", full_name: "User 6", password: "12345678", is_superuser: true})
  end
end
