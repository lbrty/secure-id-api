defmodule IdpApiWeb.Schema.ProjectTypes do
  use Absinthe.Schema.Notation

  input_object :update_project_params do
    field :project_name, :string
    field :description, :string
  end

  @desc "Projects"
  object :project do
    field :id, :id
    field :project_name, :string
    field :description, :string

    field :people_count, :integer do
      resolve &IdpApiWeb.Resolvers.Projects.people_count/2
    end
  end
end
