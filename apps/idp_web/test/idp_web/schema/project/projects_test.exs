defmodule IdpWeb.LoginSchemaTest do
  use IdpWeb.ConnCase, async: true

  setup context do
    Idp.Seeds.run()
    {:ok, context}
  end

  describe "projects ::" do
    test "only admin users can create projects", %{conn: conn} do

    end
  end
end
