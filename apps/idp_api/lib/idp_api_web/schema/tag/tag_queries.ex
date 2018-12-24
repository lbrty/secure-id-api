defmodule IdpApiWeb.Schema.TagQueries do
  use Absinthe.Schema.Notation
  alias IdpApiWeb.Resolvers.Tags

  object :tag_queries do
    @desc "Get all tags"
    field :tags, list_of(:tag) do
      resolve &Tags.list/3
    end
  end
end
