defmodule IdpApiWeb.Schema.IdpMutations do
  use Absinthe.Schema.Notation
  alias IdpApiWeb.Resolvers.IdpCategory

  object :idp_mutations do
    @desc "Create category"
    field :create_category, :idp_category do
      arg :title, non_null(:string)

      resolve &IdpCategory.create_category/3
    end

    @desc "Update category"
    field :update_category, type: :idp_category do
      arg :id, non_null(:integer)
      arg :category, :update_idp_category

      resolve &IdpCategory.update_category/3
    end

    @desc "Delete category"
    field :delete_category, type: :idp_category do
      arg :id, non_null(:integer)

      resolve &IdpCategory.delete_category/3
    end
  end
end
