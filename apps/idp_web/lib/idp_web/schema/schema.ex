defmodule IdpWeb.Schema do
  use Absinthe.Schema

  import_types(Absinthe.Type.Custom)

  import_types(IdpWeb.Schema.TextResult)

  # Import authentication definitions
  import_types(IdpWeb.Schema.AuthTypes)
  import_types(IdpWeb.Schema.AuthMutations)

  query do

  end

  mutation do
    import_fields(:auth_mutations)
  end
end
