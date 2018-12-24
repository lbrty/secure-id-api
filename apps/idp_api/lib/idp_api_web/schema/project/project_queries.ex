defmodule IdpApiWeb.Schema.ProjectQueries do
  use Absinthe.Schema.Notation
  alias IdpApiWeb.Resolvers.Projects

  object :project_queries do
    @desc "Get all projects"
    field :projects, list_of(:project) do
      resolve &Projects.list/3
    end
  end
end
