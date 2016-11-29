defmodule DevReading.PageController do
  use DevReading.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
