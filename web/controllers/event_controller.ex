defmodule Shade.EventController do
  # Using
  use Shade.Web, :controller

  # Aliases
  alias Shade.Events

  def event(conn, _param) do
    event = Events.Service.random_event()

    conn
    |> assign(:name, event.name)
    |> assign(:type, event.type)
    |> assign(:description, event.description)
    |> render("event.html")
  end

  def critic(conn, _param) do
    event = Events.Service.critic()

    conn
    |> assign(:name, event.name)
    |> assign(:type, event.type)
    |> assign(:description, event.description)
    |> render("critic.html")
  end

  def famble(conn, _param) do
    event = Events.Service.famble()

    conn
    |> assign(:name, event.name)
    |> assign(:type, event.type)
    |> assign(:description, event.description)
    |> render("famble.html")
  end
end