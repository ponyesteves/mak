defmodule MakWeb.TypeController do
  use MakWeb, :controller

  alias Mak.Transactions
  alias Mak.Transactions.Type

  def index(conn, _params) do
    types = Transactions.list_types()
    render(conn, "index.html", types: types)
  end

  def new(conn, _params) do
    changeset = Transactions.change_type(%Type{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"type" => type_params}) do
    case Transactions.create_type(type_params) do
      {:ok, type} ->
        conn
        |> put_flash(:info, "Type created successfully.")
        |> redirect(to: type_path(conn, :show, type))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    type = Transactions.get_type!(id)
    render(conn, "show.html", type: type)
  end

  def edit(conn, %{"id" => id}) do
    type = Transactions.get_type!(id)
    changeset = Transactions.change_type(type)
    render(conn, "edit.html", type: type, changeset: changeset)
  end

  def update(conn, %{"id" => id, "type" => type_params}) do
    type = Transactions.get_type!(id)

    case Transactions.update_type(type, type_params) do
      {:ok, type} ->
        conn
        |> put_flash(:info, "Type updated successfully.")
        |> redirect(to: type_path(conn, :show, type))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", type: type, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    type = Transactions.get_type!(id)
    {:ok, _type} = Transactions.delete_type(type)

    conn
    |> put_flash(:info, "Type deleted successfully.")
    |> redirect(to: type_path(conn, :index))
  end
end
