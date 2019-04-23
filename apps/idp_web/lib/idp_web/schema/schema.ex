defmodule IdpWeb.Schema do
  use Absinthe.Schema

  import_types(Absinthe.Type.Custom)

  import_types(IdpWeb.Schema.TextResult)

  import_types(IdpWeb.Schema.ProjectTypes)
  import_types(IdpWeb.Schema.ProjectQueries)
  import_types(IdpWeb.Schema.ProjectMutations)

  import_types(IdpWeb.Schema.UserTypes)
  import_types(IdpWeb.Schema.UserQueries)
  import_types(IdpWeb.Schema.UserMutations)

  import_types(IdpWeb.Schema.PermissionTypes)
  import_types(IdpWeb.Schema.PermissionQueries)
  import_types(IdpWeb.Schema.PermissionMutations)

  # Import authentication definitions
  import_types(IdpWeb.Schema.AuthTypes)
  import_types(IdpWeb.Schema.AuthMutations)

  query do
    import_fields(:project_queries)
    import_fields(:user_queries)
    import_fields(:permission_queries)
  end

  mutation do
    import_fields(:auth_mutations)
    import_fields(:project_mutations)
    import_fields(:user_mutations)
    import_fields(:permission_mutations)
  end
end
