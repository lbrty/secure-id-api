defmodule Core.Country do
  @moduledoc false
  use Core.Model

  schema "countries" do
    field(:title, :string)

    has_many(:states, Core.State)

    timestamps()
  end
end
