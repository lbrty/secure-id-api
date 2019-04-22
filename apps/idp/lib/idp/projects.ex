defmodule Idp.Projects do
  @moduledoc """
  The Projects context.
  """
  use Idp.Query

  alias Idp.Projects.Project
  alias Idp.Users.User
  alias Idp.Permissions.Permission

  @doc """
  Returns the list of projects.

  ## Examples

      iex> list_projects()
      [%Project{}, ...]

  """
  def list_projects do
    Repo.all(Project)
  end

  @doc """
  Returns the list of shared projects for `%User{} = user`.
  In case if user is superuser all projects returned
  otherwise only shared projects returned.

  ## Examples

      iex> list_for_user(user)
      [%Project{}, ...]
  """
  def list_for_user(%User{} = %{is_superuser: true}), do: list_projects()

  def list_for_user(%User{} = %{id: uid}) do
    query =
      from p in Permission,
        where: p.user_id == ^uid,
        preload: :project

    query
    |> Repo.all()
    |> Enum.map(fn p -> p.project end)
  end

  @doc """
  Gets a single project.

  Returns `nil` if the Project does not exist.

  ## Examples

      iex> get_project(123)
      %Project{}

      iex> get_project(456)
      nil
  """
  def get_project(id), do: Repo.get(Project, id)

  @doc """
  Creates a project.

  ## Examples

      iex> create_project(%{field: value})
      {:ok, %Project{}}

      iex> create_project(%{field: bad_value})
      {:error, %Ecto.Changeset{}}
  """
  def create_project(attrs \\ %{}) do
    %Project{}
    |> Project.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a project.

  ## Examples

      iex> update_project(project, %{field: new_value})
      {:ok, %Project{}}

      iex> update_project(project, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_project(%Project{} = project, attrs) do
    project
    |> Project.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Project.

  ## Examples

      iex> delete_project(project)
      {:ok, %Project{}}

      iex> delete_project(project)
      {:error, %Ecto.Changeset{}}

  """
  def delete_project(%Project{} = project) do
    Repo.delete(project)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking project changes.

  ## Examples

      iex> change_project(project)
      %Ecto.Changeset{source: %Project{}}

  """
  def change_project(%Project{} = project) do
    Project.changeset(project, %{})
  end
end
