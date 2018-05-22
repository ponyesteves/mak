defmodule CeiboBaseWeb.Guardian.AuthErrorHandler do
  import Plug.Conn
  import Phoenix.Controller, only: [put_flash: 3, redirect: 2]

  def auth_error(conn, {type, reason}, _opts) do
    # JSON RESPONSE 401
    # body = Poison.encode!(%{message: to_string(type)})
    # send_resp(conn, 401, body)
    conn
    |> put_flash(:error, "☠ Area Restringida ☠")
    |> redirect(to: CeiboBaseWeb.Router.Helpers.page_path(conn, :index))
  end
end
