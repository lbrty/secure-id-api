defmodule Core.User do
  use Core.Schema

  schema "users" do
    field(:last_name, :string)
    field(:first_name, :string)
    field(:email, :string)

    # passwords
    field(:password_hash, :string)
    field(:password, :string, virtual: true)

    # states
    field(:is_active, :boolean, default: true)
    field(:is_admin, :boolean, default: false)

    # Related permissions
    has_many(:permissions, Core.Permission)

    timestamps()
  end
end
