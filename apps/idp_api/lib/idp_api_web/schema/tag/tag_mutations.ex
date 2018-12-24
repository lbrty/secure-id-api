defmodule IdpApiWeb.Schema.TagMutations do
  use Absinthe.Schema.Notation
  alias IdpApiWeb.Resolvers.Tags

  object :tag_mutations do
    @desc "Create tag"
    field :create_tag, :tag do
      arg :name, non_null(:string)

      resolve &Tags.create_tag/3
    end

    @desc "Update tag"
    field :update_tag, type: :tag do
      arg :id, non_null(:integer)
      arg :tag, :update_tag_params

      resolve &Tags.update_tag/3
    end

    @desc "Delete tag"
    field :delete_tag, type: :tag do
      arg :id, non_null(:integer)

      resolve &Tags.delete_tag/3
    end
  end
end
