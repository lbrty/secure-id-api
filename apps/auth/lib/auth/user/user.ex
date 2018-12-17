defmodule Auth.User do
  use Ecto.Schema

  schema "users" do
    field :last_name, :string
    field :first_name, :string
    field :email, :string

    # passwords
    field :password_hash, :string
    field :password, :string, virtual: true

    # states
    field :is_active, :boolean, default: true
    field :is_admin, :boolean, default: false

    has_many :permissions, Core.Project,
      through: Auth.UserPermissions,
      on_delete: :delete_all
  end
end
