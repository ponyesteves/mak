defmodule MakWeb.GateController do
  use MakWeb, :controller

  def index(conn, _params) do
    current_user = conn.assigns[:current_user]
    IO.inspect current_user
    if(current_user.admin) do
      redirect(conn, to: backoffice_path(conn, :index))
    else
      redirect(conn, to: machine_path(conn, :index))
    end
  end
end
