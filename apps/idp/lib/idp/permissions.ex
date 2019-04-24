defmodule Idp.Permissions do
  @moduledoc """
  The Permissions context.
  """
  use Idp.Query
  alias Idp.Permissions.Permission
  alias Idp.Users.User
  alias Idp.Projects.Project

  @doc """
  Returns the list of permissions.

  ## Examples

      iex> list_permissions()
      [%Permission{}, ...]

  """
  def list_permissions do
    Repo.all(Permission)
  end

  @doc """
  Returns the list of permissions for `%User{} = user`.
  In case if user is superuser all permissions returned
  otherwise only shared permissions returned.

  ## Examples

      iex> list_for_user(user)
      [%Permission{}, ...]
  """
  def list_for_user(%User{} = user) do
    query =
      from p in Permission,
        where: p.user_id == ^user.id,
        preload: [:project, :user]

    Repo.all(query)
  end

  def for_project_and_user(%Project{} = project, %User{} = user) do
    query = from(
      p in Permission,
      where: p.user_id == ^user.id and p.project_id == ^project.id
    )

    Repo.one(query)
  end

  @doc """
  Check if given user has membership in project.
  Else we check if current user has valid
  membership.
  """
  def exists?(user, project) do
    query = from(
      m in Permission,
      where: m.project_id == ^project.id and m.user_id == ^user.id
    )

    case Repo.one(query) do
      nil -> false
      # May be consider
      # Ecto.MultipleResultsError -> false
      _ -> true
    end
  end

  @doc """
  Gets a single permission.

  Returns `nil` if the Permission does not exist.

  ## Examples

      iex> get_permission(123)
      %Permission{}

      iex> get_permission(456)
      nil

  """
  def get_permission(id), do: Repo.get(Permission, id)

  @doc """
  Creates a permission.

  ## Examples

      iex> create_permission(%{field: value})
      {:ok, %Permission{}}

      iex> create_permission(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_permission(attrs \\ %{}) do
    %Permission{}
    |> Permission.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a permission.

  ## Examples

      iex> update_permission(permission, %{field: new_value})
      {:ok, %Permission{}}

      iex> update_permission(permission, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_permission(%Permission{} = permission, attrs) do
    permission
    |> Permission.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Permission.

  ## Examples

      iex> delete_permission(permission)
      {:ok, %Permission{}}

      iex> delete_permission(permission)
      {:error, %Ecto.Changeset{}}

  """
  def delete_permission(%Permission{} = permission) do
    Repo.delete(permission)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking permission changes.

  ## Examples

      iex> change_permission(permission)
      %Ecto.Changeset{source: %Permission{}}

  """
  def change_permission(%Permission{} = permission) do
    Permission.changeset(permission, %{})
  end
end
