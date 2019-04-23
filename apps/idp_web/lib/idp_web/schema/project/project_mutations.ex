defmodule IdpWeb.Schema.ProjectMutations do
  use Absinthe.Schema.Notation
  alias IdpWeb.Schema.ProjectResolvers

  object :project_mutations do
    @desc "Create project"
    field :create_project, :project do
      arg(:name, non_null(:string))
      arg(:description, non_null(:string))

      middleware(IdpWeb.AuthRequired)
      middleware(IdpWeb.OnlyActiveUser)
      middleware(IdpWeb.OnlyAdmin)

      resolve(&ProjectResolvers.create/3)
    end

    @desc "Update project"
    field :update_project, :project do
      arg(:project_id, non_null(:integer))
      arg(:project, :update_project_params)

      middleware(IdpWeb.AuthRequired)
      middleware(IdpWeb.OnlyActiveUser)
      middleware(IdpWeb.OnlyAdmin)

      resolve(&ProjectResolvers.update/3)
    end

    @desc "Delete project"
    field :delete_project, :project do
      arg(:project_id, non_null(:integer))

      middleware(IdpWeb.AuthRequired)
      middleware(IdpWeb.OnlyActiveUser)
      middleware(IdpWeb.OnlyAdmin)

      resolve(&ProjectResolvers.delete/3)
    end

    @desc "Leave project"
    field :leave_project, :project do
      arg(:project_id, non_null(:integer))

      middleware(IdpWeb.AuthRequired)
      middleware(IdpWeb.OnlyActiveUser)

      resolve(&ProjectResolvers.leave/3)
    end
  end
end
