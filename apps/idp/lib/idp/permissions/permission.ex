defmodule Idp.Permissions.Permission do
  use Ecto.Schema
  import Ecto.Changeset

  schema "permissions" do
    field :can_create, :boolean, default: false
    field :can_delete, :boolean, default: false
    field :can_read, :boolean, default: false
    field :can_update, :boolean, default: false
    field :view_contacts, :boolean, default: false
    field :view_documents, :boolean, default: false
    field :view_personal, :boolean, default: false

    timestamps()
  end

  @required_params [
    :can_create,
    :can_read,
    :can_update,
    :can_delete,
    :view_contacts,
    :view_personal,
    :view_documents
  ]

  @doc false
  def changeset(permission, attrs) do
    permission
    |> cast(attrs, @required_params)
    |> validate_required(@required_params)
  end
end
