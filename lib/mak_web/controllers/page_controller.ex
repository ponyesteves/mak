defmodule MakWeb.PageController do
  use MakWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
