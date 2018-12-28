defmodule IdpApiWeb.Schema.ProjectMutations do
  use Absinthe.Schema.Notation
  alias IdpApiWeb.Resolvers.ProjectResolvers

  object :project_mutations do
    @desc "Create project"
    field :create_project, :project do
      arg :project_name, non_null(:string)
      arg :description, non_null(:string)

      middleware IdpApiWeb.Middleware.AdminOnly
      resolve &ProjectResolvers.create_project/2
    end

    @desc "Update project"
    field :update_project, type: :project do
      arg :id, non_null(:integer)
      arg :project, :update_project_params

      middleware IdpApiWeb.Middleware.AdminOnly
      resolve &ProjectResolvers.update_project/2
    end

    @desc "Delete project"
    field :delete_project, type: :project do
      arg :id, non_null(:integer)

      middleware IdpApiWeb.Middleware.AdminOnly
      resolve &ProjectResolvers.delete_project/2
    end
  end
end
