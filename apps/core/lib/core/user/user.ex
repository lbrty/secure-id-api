defmodule Core.User do
  @moduledoc false
  use Core.Model

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

  @doc false
  def changeset(params) do
    %Core.User{} |> changeset(params)
  end

  @doc false
  def changeset(user, params) do
    cast(user, params, ~w(email password first_name last_name is_active is_admin))
    |> validate_required([:email, :password])
    |> validate_format(:email, ~r/.*@.*/)
    |> validate_length(:password, min: 8)
    |> unique_constraint(:email)
    |> put_password_hash()
  end

  defp put_password_hash(%{changes: %{password: password}} = changeset) do
    put_change(changeset, :password_hash, Argon2.hash_pwd_salt(password))
  end

  defp put_password_hash(%{changes: %{}} = changeset), do: changeset
end
