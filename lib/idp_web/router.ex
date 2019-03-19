defmodule IdpWeb.Router do
  use IdpWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", IdpWeb do
    pipe_through :api
  end
end
