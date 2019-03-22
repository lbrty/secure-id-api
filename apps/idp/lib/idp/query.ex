defmodule Idp.Query do
  @moduledoc """
  Setup common query base for all context managers.
  Imports and expands in macro `Ecto.Query` and `Idp.Repo`.
  """

  defmacro __using__(_) do
    quote do
      import Ecto.Query, warn: false
      alias Idp.Repo
    end
  end
end
