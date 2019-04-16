defmodule IdpWeb.Schema do
  use Absinthe.Schema

  import_types(Absinthe.Type.Custom)

  import_types(IdpWeb.Schema.TextResult)

  import_types(IdpWeb.Schema.ProjectTypes)
  import_types(IdpWeb.Schema.ProjectQueries)
  import_types(IdpWeb.Schema.ProjectMutations)

  # Import authentication definitions
  import_types(IdpWeb.Schema.AuthTypes)
  import_types(IdpWeb.Schema.AuthMutations)

  query do
    import_fields(:project_queries)
  end

  mutation do
    import_fields(:auth_mutations)
    import_fields(:project_mutations)
  end
end
