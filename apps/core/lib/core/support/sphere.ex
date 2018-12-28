defmodule Core.Sphere do
  use Core.Model

  schema "spheres" do
    field(:title, :string)

    # Can be one of `s` - Social, l - Judicial
    field(:type, :string)

    timestamps()
  end
end
