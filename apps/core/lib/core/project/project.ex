defmodule Core.Project do
  @moduledoc false
  use Ecto.Schema

  @timestamp_opts [type: :utc_datetime]
  schema "projects" do
    field(:project_name, :string)
    field(:description, :string)

    # Related permissions
    has_many(:permissions, Core.Permission)

    timestamps()
  end
end
