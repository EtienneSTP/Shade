defmodule ShadeWeb.PageController do
  use ShadeWeb.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
