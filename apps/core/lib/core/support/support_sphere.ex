defmodule Core.SupportSphere do
  use Core.Model
  alias Core.{Sphere, Support}

  @primary_key false
  schema "supports_spheres" do
    belongs_to(:support, Support)
    belongs_to(:sphere, Sphere)
  end
end
