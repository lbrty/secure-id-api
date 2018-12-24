defmodule Core.City do
  @moduledoc false
  use Core.Model

  schema "cities" do
    field(:title, :string)

    belongs_to(:state, Core.State)

    timestamps()
  end
end
