defmodule Shade.EventController do
  # Using
  use Shade.Web, :controller

  # Aliases
  alias Shade.Events.Service

  def event(conn, _param) do
    event = Service.play_random()

    conn
    |> assign(:name, event.name)
    |> assign(:type, event.type)
    |> assign(:description, event.description)
    |> render("event.html")
  end

  def critic(conn, _param) do
    event = Service.play_crit_famble("critic")

    conn
    |> assign(:name, event.name)
    |> assign(:type, event.type)
    |> assign(:description, event.description)
    |> render("critic.html")
  end

  def famble(conn, _param) do
    event = Service.play_crit_famble("famble")

    conn
    |> assign(:name, event.name)
    |> assign(:type, event.type)
    |> assign(:description, event.description)
    |> render("famble.html")
  end

  def test_random(conn, _param) do
    test_random = Service.test_random()

    conn
    |> assign(:result, test_random)
    |> render("test.html")
  end
end