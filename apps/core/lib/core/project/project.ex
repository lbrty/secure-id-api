defmodule Core.Project do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  schema "projects" do
    field :project_name, :string
    field :description, :string

    # Related permissions
    has_many :permissions, Core.Permission

    timestamps(type: :utc_datetime)
  end
end
