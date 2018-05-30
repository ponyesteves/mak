defmodule MakWeb.OrderController do
  use MakWeb, :controller

  alias Mak.Transactions
  alias Mak.Transactions.Order

  plug(:load_assoc, only: [:new, :edit])

  def index(conn, _params) do
    orders = Transactions.list_orders()
    render(conn, "index.html", orders: orders)
  end

  def new(conn, %{"machine_id" => machine_id}) do
    changeset = Order.changeset(%Order{}, %{"machine_id" => machine_id})
    render(conn, "new.html", changeset: changeset, machine_id: machine_id)
  end

  def create(conn, %{"order" => order_params}) do
    pendiente_id = Mak.Transactions.get_code_by_name!("Pendiente").id

    case Transactions.create_order(Map.put(order_params, "status_id", pendiente_id)) do
      {:ok, order} ->
        conn
        |> put_flash(:info, dgettext("flash", "Order %{id} created successfully.", id: order.id ))
        |> redirect(to: order_path(conn, :show, order))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    order = Transactions.get_order!(id)
    render(conn, "show.html", order: order)
  end

  def edit(conn, %{"id" => id}) do
    order = Transactions.get_order!(id)
    changeset = Transactions.change_order(order)
    render(conn, "edit.html", order: order, changeset: changeset)
  end

  def update(conn, %{"id" => id, "order" => order_params}) do
    order = Transactions.get_order!(id)

    case Transactions.update_order(order, order_params) do
      {:ok, order} ->
        conn
        |> put_flash(:info, "Order updated successfully.")
        |> redirect(to: order_path(conn, :show, order))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", order: order, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    order = Transactions.get_order!(id)
    {:ok, _order} = Transactions.delete_order(order)

    conn
    |> put_flash(:info, "Order deleted successfully.")
    |> redirect(to: order_path(conn, :index))
  end

  defp load_assoc(conn, _) do
    Plug.Conn.assign(conn, :types, Transactions.list_codes("type") |> MakWeb.Helpers.to_select())
  end
end
