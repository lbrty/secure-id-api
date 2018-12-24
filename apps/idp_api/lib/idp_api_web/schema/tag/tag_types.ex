defmodule IdpApiWeb.Schema.TagTypes do
  use Absinthe.Schema.Notation

  input_object :update_tag_params do
    field :name, :string
  end

  @desc "Tags"
  object :tag do
    field :id, :id
    field :name, :string
  end
end
