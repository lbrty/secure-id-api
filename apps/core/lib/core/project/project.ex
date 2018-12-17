defmodule Core.Project do
  @moduledoc false
  use Ecto.Schema

  schema "projects" do
    field :project_name, :string
    field :description, :string

    timestamps(type: :utc_datetime)
  end
end
