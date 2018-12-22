defmodule IdpApiWeb.Schema.ProjectTypes do
  use Absinthe.Schema.Notation

  @desc "Projects"
  object :project do
    field :id, :id
    field :project_name, :string
    field :description, :string
  end
end
