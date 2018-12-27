defmodule IdpApiWeb.Router do
  use IdpApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug IdpApiWeb.Context
  end

  scope "/" do
    pipe_through :api

    forward "/api", Absinthe.Plug,
      schema: IdpApiWeb.Schema

    forward "/playground", Absinthe.Plug.GraphiQL,
      schema: IdpApiWeb.Schema,
      interface: :playground
  end
end
