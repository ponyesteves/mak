defmodule MakWeb.MachineController do
  use MakWeb, :controller

  import MakWeb.Gettext, only: [dgettext: 2]

  alias Mak.Base
  alias Mak.Base.Machine

  def index(conn, params) do
    machines = Base.list_machines(params["q"])
    render(conn, "index.html", machines: machines)
  end

  def new(conn, _params) do
    changeset = Base.change_machine(%Machine{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"machine" => machine_params}) do
    case Base.create_machine(machine_params) do
      {:ok, machine} ->
        conn
        |> put_flash(:info, dgettext("flash", "Machine created successfully."))
        |> redirect(to: machine_path(conn, :show, machine))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    machine = Base.get_machine!(id)
    render(conn, "show.html", machine: machine)
  end

  def edit(conn, %{"id" => id}) do
    machine = Base.get_machine!(id)
    changeset = Base.change_machine(machine)
    render(conn, "edit.html", machine: machine, changeset: changeset)
  end

  def update(conn, %{"id" => id, "machine" => machine_params}) do
    machine = Base.get_machine!(id)

    case Base.update_machine(machine, machine_params) do
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
end
