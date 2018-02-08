defmodule Shade.Router do
  # Using
  use Shade.Web, :router

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

  scope "/", Shade do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/event", Shade do
    pipe_through(:browser)

    get "/", EventController, :event
    get "/critic", EventController, :critic
    get "/famble", EventController, :famble
    get "/test", EventController, :test_random
  end

  scope "test", Shade do
    pipe_through(:browser)

    get "/joke", TestController, :joke
  end
end
