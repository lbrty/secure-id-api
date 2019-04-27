defmodule IdpWeb.Schema.CityTypes do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: Idp.Repo

  @desc "City"
  object :city do
    field(:id, :id)
    field(:name, :string)
    field(:state, :state, resolve: assoc(:state))
  end
end
