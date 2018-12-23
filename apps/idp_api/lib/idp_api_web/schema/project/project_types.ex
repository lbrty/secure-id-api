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
  end
end
