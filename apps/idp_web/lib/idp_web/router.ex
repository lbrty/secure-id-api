defmodule IdpWeb.Router do
  use IdpWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug IdpWeb.Context
  end

  scope "/" do
    pipe_through :api

    forward "/api", Absinthe.Plug,
      schema: IdpWeb.Schema,
      json_codec: Jason

    forward "/playground", Absinthe.Plug.GraphiQL,
      schema: IdpWeb.Schema,
      json_codec: Jason,
      interface: :playground
  end
end
