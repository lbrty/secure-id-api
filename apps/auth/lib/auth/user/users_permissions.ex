defmodule Auth.UsersPermissions do
  use Ecto.Schema

  schema "users_permissions" do
    belongs_to :user, Auth.User
    belongs_to :project, Core.Project
  end
end
