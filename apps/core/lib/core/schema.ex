defmodule Core.Schema do
  @moduledoc """
  Setup common schema base for all schema definitions.
  """

  defmacro __using__(_) do
    quote do
      use Ecto.Schema
      @timestamp_opts [type: :utc_datetime]
    end
  end
end
