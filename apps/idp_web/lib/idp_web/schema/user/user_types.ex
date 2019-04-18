defmodule IdpWeb.Schema.UserTypes do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: Idp.Repo

  @desc "User"
  object :user do
    field(:id, :id)
    field(:full_name, :string)
    field(:email, :string)
    field(:is_active, :boolean)
    field(:is_superuser, :boolean)
  end
end
