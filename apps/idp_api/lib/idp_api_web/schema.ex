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

  # Tag imports
  import_types IdpApiWeb.Schema.TagTypes
  import_types IdpApiWeb.Schema.TagQueries
  import_types IdpApiWeb.Schema.TagMutations

  query do
    import_fields :project_queries
    import_fields :idp_queries
    import_fields :tag_queries
  end

  mutation do
    import_fields :project_mutations
    import_fields :idp_status_mutations
    import_fields :idp_category_mutations
    import_fields :tag_mutations
  end
end
