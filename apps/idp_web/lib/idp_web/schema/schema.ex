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

  import_types(IdpWeb.Schema.CountryTypes)
  import_types(IdpWeb.Schema.CountryQueries)
  import_types(IdpWeb.Schema.CountryMutations)

  import_types(IdpWeb.Schema.StateTypes)
  import_types(IdpWeb.Schema.StateQueries)
  import_types(IdpWeb.Schema.StateMutations)

  import_types(IdpWeb.Schema.CityTypes)
  import_types(IdpWeb.Schema.CityQueries)
  import_types(IdpWeb.Schema.CityMutations)

  # Import authentication definitions
  import_types(IdpWeb.Schema.AuthTypes)
  import_types(IdpWeb.Schema.AuthMutations)

  query do
    import_fields(:project_queries)
    import_fields(:user_queries)
    import_fields(:permission_queries)
    import_fields(:country_queries)
    import_fields(:state_queries)
    import_fields(:city_queries)
  end

  mutation do
    import_fields(:auth_mutations)
    import_fields(:project_mutations)
    import_fields(:user_mutations)
    import_fields(:permission_mutations)
    import_fields(:country_mutations)
    import_fields(:state_mutations)
    import_fields(:city_mutations)
  end
end
