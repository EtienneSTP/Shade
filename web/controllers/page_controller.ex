defmodule Shade.PageController do
  use Shade.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
