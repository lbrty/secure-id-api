defmodule Core.Model do
  @moduledoc """
  Setup common model base for all schema definitions.
  """

  defmacro __using__(_) do
    quote do
      use Ecto.Model

      # Set all datetimes to UTC by default
      @timestamp_opts [type: :utc_datetime]
    end
  end
end
