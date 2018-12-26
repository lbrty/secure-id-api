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

  # World imports
  import_types IdpApiWeb.Schema.WorldTypes
  import_types IdpApiWeb.Schema.WorldQueries
  import_types IdpApiWeb.Schema.WorldMutations

  # User imports
  import_types IdpApiWeb.Schema.PermissionTypes

  # User imports
  import_types IdpApiWeb.Schema.UserTypes
  import_types IdpApiWeb.Schema.UserQueries
  import_types IdpApiWeb.Schema.UserMutations

  # Auth
  import_types IdpApiWeb.Schema.AuthTypes
  import_types IdpApiWeb.Schema.AuthMutations

  query do
    import_fields :project_queries
    import_fields :idp_queries
    import_fields :tag_queries
    import_fields :world_queries
    import_fields :user_queries
  end

  mutation do
    import_fields :project_mutations
    import_fields :idp_status_mutations
    import_fields :idp_category_mutations
    import_fields :tag_mutations
    import_fields :world_mutations
    import_fields :user_mutations
    import_fields :auth_mutations
  end
end
