defmodule IdpWeb.Router do
  use IdpWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug IdpWeb.Context
  end

  scope "/api", IdpWeb do
    pipe_through :api

    forward "/playground", Absinthe.Plug.GraphiQL,
      schema: IdpWeb.Schema,
      interface: :playground
  end
end
