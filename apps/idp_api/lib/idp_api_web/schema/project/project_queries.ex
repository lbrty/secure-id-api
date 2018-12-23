defmodule IdpApiWeb.Schema.ProjectQueries do
  use Absinthe.Schema.Notation
  alias IdpApiWeb.Resolvers

  object :project_queries do
    @desc "Get all projects"
    field :projects, list_of(:project) do
      resolve &Resolvers.Projects.list/3
    end
  end
end
