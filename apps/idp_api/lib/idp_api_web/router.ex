defmodule IdpApiWeb.Router do
  use IdpApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  forward "/api",
    Absinthe.Plug,
    init_opts: [schema: IdpApiWeb.Schema]

  forward "/graphiql",
    Absinthe.Plug.GraphiQL,
    schema: IdpApiWeb.Schema,
    interface: :simple
end