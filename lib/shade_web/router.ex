defmodule Shade.Router do
  # Using
  use ShadeWeb.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ShadeWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/event", ShadeWeb do
    pipe_through(:browser)

    get "/", EventController, :event
    get "/critic", EventController, :critic
    get "/famble", EventController, :famble
    get "/test", EventController, :test_random
  end

  scope "/test", ShadeWeb do
    pipe_through(:browser)

    get "/joke", TestController, :joke
  end

  forward "/graphql",
          Absinthe.Plug,
          schema: ShadeGraphql.Schema

  forward "/graphiql",
          Absinthe.Plug.GraphiQL,
          schema: ShadeGraphql.Schema,
          interface: :simple
end
