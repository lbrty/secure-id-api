defmodule IdpApiWeb.Resolvers.Projects do
  alias Core.ProjectActions

  @not_authorized_error {:error, "Not Authorized"}

  def list(_parent, %{context: %{current_user: _user}}) do
    {:ok, ProjectActions.list()}
  end

  def list(_parent, _args), do: @not_authorized_error

  def create_project(args, _info) do
    {:ok, ProjectActions.create(args)}
  end

  def update_project(args, _context) do
    ProjectActions.update(args)
  end

  def delete_project(args, _context) do
    ProjectActions.delete(args)
  end
end
