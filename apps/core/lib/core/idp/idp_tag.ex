defmodule Core.IdpTag do
  @moduledoc false
  use Core.Model

  # This is just a join table for m2m
  # relationship between Idps and tags.
  @primary_key false
  schema "idps_tags" do
    belongs_to(:idp, Core.Idp)
    belongs_to(:tag, Core.Tag)

    timestamps()
  end
end
