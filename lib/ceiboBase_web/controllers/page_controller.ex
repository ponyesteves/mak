defmodule CeiboBaseWeb.PageController do
  use CeiboBaseWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
