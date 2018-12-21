defmodule Core.Tag do
  use Core.Schema

  schema "tags" do
    field(:name, :string)
  end
end
