defmodule IdpWeb.Schema.StateTypes do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: Idp.Repo

  @desc "State"
  object :state do
    field(:name, :string)
    field(:country, :country, resolve: assoc(:country))
  end
end
