defmodule IdpApiWeb.Schema.IdpTypes do
  use Absinthe.Schema.Notation

  input_object :update_idp_category do
    field :title, :string
  end

  input_object :update_idp_status do
    field :title, :string
  end

  @desc "Vulnerability categories (IdpCategory)"
  object :idp_category do
    field :id, :id
    field :title, :string
  end

  @desc "Idp statuses"
  object :idp_status do
    field :id, :id
    field :title, :string
  end
end
