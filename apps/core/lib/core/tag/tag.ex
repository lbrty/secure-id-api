defmodule Core.Tag do
  @moduledoc false
  use Core.Schema

  schema "tags" do
    field(:name, :string)
  end
end
