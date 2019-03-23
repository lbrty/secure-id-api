defmodule IdpWeb.Schema.TextResult do
  use Absinthe.Schema.Notation

  @desc "Text result for mutations, for example 'ok', 'error' etc."
  object :text_result do
    field(:result, :string)
  end
end
