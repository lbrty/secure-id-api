defmodule IdpWeb.Schema.StateTypes do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: Idp.Repo

  @desc "State"
  object :state do
    field(:id, :id)
    field(:name, :string)
    field(:country, :country, resolve: assoc(:country))
    field(:cities, list_of(:city), resolve: assoc(:cities))
  end
end
