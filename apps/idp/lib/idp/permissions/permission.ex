defmodule Idp.Permissions.Permission do
  use Idp.Model

  alias Idp.Projects.Project
  alias Idp.Users.User

  schema "permissions" do
    field :can_create, :boolean, default: false
    field :can_delete, :boolean, default: false
    field :can_read, :boolean, default: false
    field :can_update, :boolean, default: false
    field :view_contacts, :boolean, default: false
    field :view_documents, :boolean, default: false
    field :view_personal, :boolean, default: false

    belongs_to :user, User
    belongs_to :project, Project

    timestamps()
  end

  @required_params [
    :can_create,
    :can_read,
    :can_update,
    :can_delete,
    :view_contacts,
    :view_personal,
    :view_documents,
    :user_id,
    :project_id
  ]

  @doc false
  def changeset(permission, attrs) do
    permission
    |> cast(attrs, @required_params)
    |> validate_required(@required_params)
  end
end
