defmodule IdpWeb.Schema.PermissionQueries do
  use Absinthe.Schema.Notation
  alias IdpWeb.Schema.PermissionResolvers

  object :permission_queries do
    @desc "Get permissions"
    field :permssions, list_of(:permission) do
      arg(:user_id, :integer)

      middleware(IdpWeb.AuthRequired)
      middleware(IdpWeb.OnlyActiveUser)

      resolve(&PermissionResolvers.list/3)
    end
  end
end
