defmodule IdpWeb.Schema.CountryTypes do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: Idp.Repo

  @desc "Country input"
  input_object :country_input do
    field(:name, :string)
  end

  @desc "Country"
  object :country do
    field(:name, :string)
  end
end
