defmodule IdpWeb.Schema.ProjectMutations do
  use Absinthe.Schema.Notation
  alias IdpWeb.Schema.ProjectResolvers

  object :project_mutations do
    @desc "Create project"
    field :create_project, :project do
      arg :name, non_null(:string)
      arg :description, non_null(:string)

      middleware IdpWeb.AuthRequired
      middleware IdpWeb.OnlyActiveUser
      middleware IdpWeb.OnlyAdmin

      resolve &ProjectResolvers.create/3
    end
  end
end
