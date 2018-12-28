defmodule IdpApiWeb.Schema.ProjectQueries do
  use Absinthe.Schema.Notation
  alias IdpApiWeb.Resolvers.ProjectResolvers

  object :project_queries do
    @desc "Get all projects"
    field :projects, list_of(:project) do
      resolve &ProjectResolvers.list/2
    end
  end
end
