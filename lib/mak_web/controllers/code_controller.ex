defmodule MakWeb.CodeController do
  use MakWeb, :controller

  alias Mak.Transactions
  alias Mak.Transactions.Code

  def index(conn, _params) do
    codes = Transactions.list_codes()
    render(conn, "index.html", codes: codes)
  end

  def new(conn, _params) do
    changeset = Transactions.change_code(%Code{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"code" => code_params}) do
    case Transactions.create_code(code_params) do
      {:ok, code} ->
        conn
        |> put_flash(:info, "Code created successfully.")
        |> redirect(to: code_path(conn, :show, code))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    code = Transactions.get_code!(id)
    render(conn, "show.html", code: code)
  end

  def edit(conn, %{"id" => id}) do
    code = Transactions.get_code!(id)
    changeset = Transactions.change_code(code)
    render(conn, "edit.html", code: code, changeset: changeset)
  end

  def update(conn, %{"id" => id, "code" => code_params}) do
    code = Transactions.get_code!(id)

    case Transactions.update_code(code, code_params) do
      {:ok, code} ->
        conn
        |> put_flash(:info, "Code updated successfully.")
        |> redirect(to: code_path(conn, :show, code))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", code: code, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    code = Transactions.get_code!(id)
    {:ok, _code} = Transactions.delete_code(code)

    conn
    |> put_flash(:info, "Code deleted successfully.")
    |> redirect(to: code_path(conn, :index))
  end
end
