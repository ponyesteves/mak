defmodule MakWeb.MachineController do
  use MakWeb, :controller

  import MakWeb.Gettext, only: [dgettext: 2]

  alias Mak.Base
  alias Mak.Base.Machine

  def index(conn, params) do
    query = params["q"]
    # TODO: if query got to correct tab
    machines = Base.list_machines(query)
    render(conn, "index.html", machines: machines, query: query)
  end

  def new(conn, _params) do
    changeset = Base.change_machine(%Machine{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"machine" => machine_params}) do
    case Base.create_machine(parse_image(machine_params)) do
      {:ok, machine} ->
        conn
        |> put_flash(:info, dgettext("flash", "Machine created successfully."))
        |> redirect(to: machine_path(conn, :show, machine))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id} = params) do
    # TODO use query param and search between orders
    # https://medium.com/@victoriawagman/filter-results-from-a-many-to-many-query-ecto-2eaa28cba59f
    machine = Base.get_machine!(id, params["orders_query"])
    changeset = Base.change_machine(machine)
    render(conn, "show.html", machine: machine, changeset: changeset)
  end

  def edit(conn, %{"id" => id}) do
    machine = Base.get_machine!(id)
    changeset = Base.change_machine(machine)
    render(conn, "edit.html", machine: machine, changeset: changeset)
  end

  def update(conn, %{"id" => id, "machine" => machine_params}) do
    machine = Base.get_machine!(id)

    case Base.update_machine(machine, parse_image(machine_params)) do
      {:ok, machine} ->
        conn
        |> put_flash(:info, dgettext("flash", "Machine updated successfully."))
        |> redirect(to: machine_path(conn, :show, machine))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", machine: machine, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    machine = Base.get_machine!(id)
    {:ok, _machine} = Base.delete_machine(machine)

    conn
    |> put_flash(:info, dgettext("flash", "Machine deleted successfully."))
    |> redirect(to: machine_path(conn, :index))
  end

  defp parse_image(machine_params) do
    image = machine_params["image"]

    case image do
      nil -> machine_params
      _ -> Map.put(machine_params, "image", File.read!(image.path))
    end
  end
end
