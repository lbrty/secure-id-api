defmodule Core.Project do
  @moduledoc false
  use Core.Schema

  schema "projects" do
    field(:project_name, :string)
    field(:description, :string)

    # Related permissions
    has_many(:permissions, Core.Permission)

    timestamps()
  end
end
