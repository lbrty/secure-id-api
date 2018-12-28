defmodule IdpApiWeb.Resolvers.Projects do
  alias Core.ProjectActions
  alias IdpApiWeb.Helpers.AuthHelpers

  @not_authorized_error {:error, "Not Authorized"}

  def list(_parent, %{context: %{current_user: _user}}) do
    {:ok, ProjectActions.list()}
  end

  def list(_parent, _args), do: @not_authorized_error

  def create_project(args, %{context: %{current_user: user}}) do
    if AuthHelpers.is_admin(user) do
      {:ok, ProjectActions.create(args)}
    else
      @not_authorized_error
    end
  end

  def create_project(_args, _context), do: @not_authorized_error

  def update_project(args, _context) do
    ProjectActions.update(args)
  end

  def delete_project(args, _context) do
    ProjectActions.delete(args)
  end
end
