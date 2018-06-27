defmodule MakWeb.OrderController do
  use MakWeb, :controller

  alias Mak.Transactions
  alias Mak.Transactions.Order
  alias Mak.Base


  plug(:load_assoc, only: [:new, :edit])

  def index(conn, params) do
    orders = Transactions.list_orders_by_status(params["status"] || 3)
    render(conn, "index.html", orders: orders, status: (params["status"] || "3") |> String.to_integer)
  end

  def new(conn, %{"machine_id" => machine_id}) do
    changeset = Order.changeset(%Order{}, %{"machine_id" => machine_id})
    machine = Base.get_machine!(machine_id)
    render(conn, "new.html", changeset: changeset, machine: machine, machine_id: machine_id)
  end

  def create(conn, %{"order" => order_params}) do
    pendiente_id = Mak.Transactions.get_code_by_name!("Pendiente").id

    case Transactions.create_order(Map.put(order_params, "status_id", pendiente_id)) do
      {:ok, order} ->
        conn
        |> put_flash(:info, dgettext("flash", "Order %{id} created successfully.", id: order.id ))
        |> redirect(to: order_path(conn, :show, order))

      {:error, %Ecto.Changeset{} = changeset} ->
        machine_id = Ecto.Changeset.get_field(changeset, :machine_id)
        render(conn, "new.html", changeset: changeset, machine_id: machine_id)
    end
  end

  def show(conn, %{"id" => id}) do
    order = Transactions.get_order!(id)
    render(conn, "show.html", order: order)
  end

  def edit(conn, %{"id" => id}) do
    order = Transactions.get_order!(id)
    changeset = Transactions.change_order(order)
    machine = Base.get_machine!(order.machine_id)
    render(conn, "edit.html", order: order, changeset: changeset, machine: machine)
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

  def change_status(conn, %{"id" => id, "status" => status}) do
    order = Transactions.get_order!(id)
    Transactions.update_order(order, %{"status_id" => status})

    redirect(conn, to: order_path(conn, :index))
  end

  defp load_assoc(conn, _) do
    Plug.Conn.assign(conn, :types, Transactions.list_codes("type") |> MakWeb.Helpers.to_select())
  end
end
