defmodule Idp.Model do
  @moduledoc """
  Setup common model base for all schema definitions.
  Also `Ecto.Changeset` is automatically imported so
  no need to import in child schemas.
  """

  defmacro __using__(_) do
    quote do
      use Ecto.Schema

      import Ecto.Changeset
      import Ecto.Query

      # Set all datetimes to UTC by default
      @timestamp_opts [type: :utc_datetime]
    end
  end
end
