defmodule IdpApiWeb.Schema.IdpMutations do
  use Absinthe.Schema.Notation
  alias IdpApiWeb.Resolvers.IdpCategory
  alias IdpApiWeb.Resolvers.IdpStatus

  object :idp_category_mutations do
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

  object :idp_status_mutations do
    @desc "Create status"
    field :create_status, :idp_status do
      arg :title, non_null(:string)

      resolve &IdpStatus.create_status/3
    end

    @desc "Update status"
    field :update_status, type: :idp_status do
      arg :id, non_null(:integer)
      arg :status, :update_idp_status

      resolve &IdpStatus.update_status/3
    end

    @desc "Delete category"
    field :delete_status, type: :idp_status do
      arg :id, non_null(:integer)

      resolve &IdpStatus.delete_status/3
    end
  end
end
