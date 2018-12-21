defmodule Core.Tag do
  use Ecto.Schema

  @timestamp_opts [type: :utc_datetime]
  schema "tags" do
    field(:name, :string)
  end
end
