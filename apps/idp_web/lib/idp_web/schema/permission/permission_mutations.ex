defmodule IdpWeb.Schema.PermissionMutations do
  use Absinthe.Schema.Notation
  alias IdpWeb.Schema.PermissionResolvers

  object :permission_mutations do
    @desc "Share project"
    field :share_project, :permission do
      arg(:project_id, non_null(:integer))
      arg(:user_id, non_null(:integer))
      arg(:permission, :permission_input)

      middleware(IdpWeb.AuthRequired)
      middleware(IdpWeb.OnlyActiveUser)
      middleware(IdpWeb.OnlyAdmin)

      resolve(&PermissionResolvers.create/3)
    end
  end
end
