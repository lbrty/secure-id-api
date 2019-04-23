defmodule IdpWeb.Schema.PermissionTypes do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: Idp.Repo

  @desc "Permission input"
  input_object :permission_input do
    field(:can_create, :boolean)
    field(:can_delete, :boolean)
    field(:can_read, :boolean)
    field(:can_update, :boolean)
    field(:view_contacts, :boolean)
    field(:view_documents, :boolean)
    field(:view_personal, :boolean)
  end

  @desc "Permission"
  object :permission do
    field(:can_create, :boolean)
    field(:can_delete, :boolean)
    field(:can_read, :boolean)
    field(:can_update, :boolean)
    field(:view_contacts, :boolean)
    field(:view_documents, :boolean)
    field(:view_personal, :boolean)
    field(:user, :user, resolve: assoc(:user))
    field(:project, :project, resolve: assoc(:project))
  end
end
