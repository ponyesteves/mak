defmodule CeiboBaseWeb.Auth do
  import Plug.Conn
  import Phoenix.Controller
  import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]

  alias CeiboBaseWeb.Router.Helpers

  def login(conn, user) do
    conn
    |> CeiboBase.Guardian.Plug.sign_in(user)
  end

  def logout(conn) do
    conn
    |> CeiboBase.Guardian.Plug.sign_out()
  end

  def login_by_username_and_pass(conn, username, given_pass, opts) do
    repo = Keyword.fetch!(opts, :repo)
    user = repo.get_by(CeiboBase.Accounts.User, username: username)

    cond do
      user && checkpw(given_pass, user.password_hash) ->
        {:ok, login(conn, user)}
      user ->
        {:error, :unauthorized, conn}
      true  ->
        dummy_checkpw()
        {:error, :not_found, conn}
    end
  end
end
