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
    :password,
    :is_active,
    :is_superuser
  ]

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, @required_params ++ [:password_hash])
    |> validate_required(@required_params)
    |> validate_format(:email, ~r/.*@.*/)
    |> validate_length(:password, min: 8)
    |> unique_constraint(:email)
    |> put_password_hash()
  end

  @doc false
  def update_changeset(user, attrs) do
    required_params =
      @required_params
      |> Enum.reject(fn x -> x == :password end)

    user
    |> cast(attrs, required_params)
    |> validate_required(required_params)
    |> validate_format(:email, ~r/.*@.*/)
    |> unique_constraint(:email)
  end

  defp put_password_hash(%{changes: %{password: password}} = changeset) do
    changeset
    |> put_change(:password_hash, Auth.hash_password(password))
  end

  defp put_password_hash(%{changes: %{}} = changeset), do: changeset
end
