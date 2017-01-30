defmodule DevReading.PageController do
  use DevReading.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def page404(conn, _params) do
    render conn, "404.html"
  end
end
