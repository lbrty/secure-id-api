defmodule Idp.Users.User do
  use Idp.Model

  schema "users" do
    field :email, :string
    field :full_name, :string
    field :password_hash, :string
    field :password, :string, virtual: true

    field :is_active, :boolean, default: false
    field :is_superuser, :boolean, default: false

    timestamps()
  end

  @required_params [
    :email,
    :full_name,
    :password_hash,
    :is_active,
    :is_superuser
  ]

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, @required_params)
    |> validate_required(@required_params)
  end
end
