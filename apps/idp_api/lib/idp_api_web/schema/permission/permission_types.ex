defmodule IdpApiWeb.Schema.PermissionTypes do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: Core.Repo

  input_object :update_permission_params do
    field :name, :string
  end

  @desc "Permissions"
  object :permission do
    field :id, :id
    field :view, :boolean
    field :edit, :boolean
    field :create, :boolean
    field :delete, :boolean

    # Means personal information like address, phone.
    field :view_personal, :boolean

    # Can view uploaded documents?
    field :view_documents, :boolean

    field :project, :project, resolve: assoc(:project)
    field :user, :user, resolve: assoc(:user)
  end
end
