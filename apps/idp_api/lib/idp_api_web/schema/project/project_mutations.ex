defmodule IdpApiWeb.Schema.ProjectMutations do
  use Absinthe.Schema.Notation
  alias IdpApiWeb.Resolvers

  object :project_mutations do
    @desc "Create project"
    field :create_project, :project do
      arg :project_name, non_null(:string)
      arg :description, non_null(:string)

      resolve &Resolvers.Projects.create_project/3
    end

    @desc "Update project"
    field :update_project, type: :project do
      arg :id, non_null(:integer)
      arg :project, :update_project_params

      resolve &Resolvers.Projects.update_project/3
    end

    @desc "Delete project"
    field :delete_project, type: :project do
      arg :id, non_null(:integer)

      resolve &Resolvers.Projects.delete_project/3
    end
  end
end
