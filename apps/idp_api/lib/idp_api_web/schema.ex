defmodule IdpApiWeb.Schema do
  use Absinthe.Schema

  import_types Absinthe.Type.Custom
  import_types IdpApiWeb.Schema.ProjectTypes
  import_types IdpApiWeb.Schema.ProjectQueries
  import_types IdpApiWeb.Schema.ProjectMutations

  query do
    import_fields :project_queries
  end

  mutation do
    import_fields :project_mutations
  end
end
