defmodule IdpApiWeb.Schema.WorldTypes do
  use Absinthe.Schema.Notation

  input_object :update_country_params do
    field :title, :string
  end

  @desc "Country"
  object :country do
    field :id, :id
    field :title, :string
  end
end
