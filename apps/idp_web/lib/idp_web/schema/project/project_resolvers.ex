defmodule IdpWeb.Schema.ProjectResolvers do
  use IdpWeb.Schema.Errors

  alias Idp.Projects

  def list(_parent, _args, _) do
    {:ok, Projects.list_projects()}
  end
end
