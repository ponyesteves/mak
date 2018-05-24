defmodule MakWeb.SessionController do
  use MakWeb, :controller

  import MakWeb.Gettext, only: [dgettext: 2, gettext: 1]

  alias MakWeb.Auth

  def new(conn, _) do
    render(conn, "new.html")
  end

  def create(conn, %{"session" => %{"username" => user, "password" => pass}}) do
    case Auth.login_by_username_and_pass(conn, user, pass, repo: Mak.Repo) do
      {:ok, conn} ->
        conn
        |> put_flash(:info, gettext("welcome"))
        |> redirect(to: machine_path(conn, :index))

      {:error, _reason, conn} ->
        conn
        |> put_flash(:error, dgettext("flash", "invalid credentials"))
        |> render("new.html")
    end
  end

  def drop(conn, _) do
    conn
    |> Auth.logout()
    |> put_flash(:info, dgettext("flash", "see you"))
    |> redirect(to: session_path(conn, :new))
  end
end
