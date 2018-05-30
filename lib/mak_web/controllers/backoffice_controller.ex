defmodule MakWeb.BackofficeController do
  use MakWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
