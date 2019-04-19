defmodule IdpWeb.WebCase do

  defmacro __using__(_) do
    quote do
      use ExUnit.Case
      use IdpWeb.ConnCase, async: true

      setup context do
        Idp.Seeds.run()
        {:ok, context}
      end
    end
  end
end
