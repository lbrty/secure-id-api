defmodule Idp.Projects.Project do
  use Idp.Model

  alias Idp.Permissions.Permission

  schema "projects" do
    field :name, :string
    field :description, :string

    has_many :permissions, Permission

    timestamps()
  end

  @doc false
  def changeset(project, attrs) do
    project
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
  end
end
