defmodule IdpApiWeb.Schema do
  use Absinthe.Schema

  import_types Absinthe.Type.Custom
  import_types IdpApiWeb.Schema.ProjectTypes

  alias IdpApiWeb.Resolvers

  query do
    @desc "Get all projects"
    field :projects, list_of(:project) do
      resolve &Resolvers.Projects.all/3
    end
  end
end
