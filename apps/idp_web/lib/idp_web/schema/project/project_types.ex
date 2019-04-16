defmodule IdpWeb.Schema.ProjectTypes do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: Idp.Repo

  input_object :update_project_params do
    field(:name, :string)
    field(:description, :string)
  end

  @desc "Projects"
  object :project do
    field(:id, :id)
    field(:name, :string)
    field(:description, :string)
  end
end
