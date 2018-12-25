defmodule IdpApiWeb.Schema.UserTypes do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: Core.Repo

  input_object :update_user_params do
    field :last_name, :string
    field :first_name, :string
    field :email, :string

    # passwords
    field :password, :string

    # states
    field :is_active, :boolean
    field :is_admin, :boolean
  end

  @desc "Users"
  object :user do
    field :id, :id
    field :last_name, :string
    field :first_name, :string
    field :email, :string

    # passwords
    field :password, :string

    # states
    field :is_active, :boolean
    field :is_admin, :boolean

    # Related permissions
    field :permissions, list_of(:permission), resolve: assoc(:permissions)
  end
end
