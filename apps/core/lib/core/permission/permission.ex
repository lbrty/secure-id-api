defmodule Core.Permission do
  @moduledoc false
  use Core.Model

  schema "permissions" do
    # General purpose permissions
    field(:view, :boolean, default: true)
    field(:edit, :boolean, default: false)
    field(:create, :boolean, default: false)
    field(:delete, :boolean, default: false)

    # Means personal information like address, phone.
    field(:view_personal, :boolean, default: false)

    # Can view uploaded documents?
    field(:view_documents, :boolean, default: false)

    belongs_to(:project, Core.Project)
    belongs_to(:user, Core.User)
  end
end
