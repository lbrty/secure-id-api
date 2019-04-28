defmodule Idp.IdpCase do
  defmacro __using__(_) do
    quote do
      use Idp.DataCase, async: true

      setup do
        Idp.Seeds.run()
        :ok
      end
    end
  end
end
