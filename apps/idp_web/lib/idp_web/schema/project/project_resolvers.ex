defmodule IdpWeb.Schema.ProjectResolvers do
  use IdpWeb.Schema.Errors

  alias Idp.Projects

  def create(_parent, project, _context) do
    Projects.create_project(project)
  end

  def list(_parent, _args, _) do
    {:ok, Projects.list_projects()}
  end

end
