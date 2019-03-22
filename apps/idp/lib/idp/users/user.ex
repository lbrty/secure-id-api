defmodule Idp.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :full_name, :string
    field :is_active, :boolean, default: false
    field :is_superuser, :boolean, default: false
    field :password_hash, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :full_name, :password_hash, :is_active, :is_superuser])
    |> validate_required([:email, :full_name, :password_hash, :is_active, :is_superuser])
  end
end
