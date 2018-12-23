defmodule IdpApiWeb.Schema do
  use Absinthe.Schema

  import_types Absinthe.Type.Custom

  # Project imports
  import_types IdpApiWeb.Schema.ProjectTypes
  import_types IdpApiWeb.Schema.ProjectQueries
  import_types IdpApiWeb.Schema.ProjectMutations

  # IDP imports
  import_types IdpApiWeb.Schema.IdpTypes
  import_types IdpApiWeb.Schema.IdpQueries
  import_types IdpApiWeb.Schema.IdpMutations

  query do
    import_fields :project_queries
    import_fields :idp_queries
  end

  mutation do
    import_fields :project_mutations
    import_fields :idp_mutations
  end
end
