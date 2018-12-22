defmodule IdpApiWeb.Schema do
  use Absinthe.Schema

  import_types Absinthe.Type.Custom
  import_types IdpApiWeb.Schema.ProjectTypes

  alias IdpApiWeb.Resolvers

  query do
    @desc "Get all projects"
    field :projects, list_of(:project) do
      resolve &Resolvers.Projects.list/3
    end
  end

  mutation do
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
