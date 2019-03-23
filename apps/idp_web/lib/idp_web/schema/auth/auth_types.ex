defmodule IdpWeb.Schema.AuthTypes do
  use Absinthe.Schema.Notation

  object :session do
    field(:token, :string)
  end
end
