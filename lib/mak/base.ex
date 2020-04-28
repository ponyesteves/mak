defmodule Mak.Base do
  @moduledoc """
  The Base context.
  """

  import Ecto.Query, warn: false
  alias Mak.Repo

  alias Mak.Base.Machine

  def list_machines(code_name \\ "") do
    query = "%#{code_name}%"

    Machine
    |> where([m], ilike(m.id, ^query) or ilike(m.name, ^query))
    |> limit(20)
    |> Repo.all()
  end

  def get_machine!(id, orders_query \\ nil) do
    query =
      from(
        o in Mak.Transactions.Order,
        where: fragment("? ~* ?", o.title, ^(orders_query || ".*"))
      )

    Machine
    |> Repo.get!(id)
    |> Repo.preload(orders: {query, [:status]})
  end

  def create_machine(attrs \\ %{}) do
    %Machine{}
    |> Machine.changeset(attrs)
    |> post_machine_to_teamplace()
    |> Repo.insert()
  end

  def upsert_machine(attrs \\ %{}) do
    case Repo.get(Machine, attrs["id"]) do
      nil ->
        create_machine(attrs)

      machine ->
        update_machine(machine, attrs)
    end
  end

  def update_machine(%Machine{} = machine, attrs) do
    machine
    |> Machine.changeset(attrs)
    |> Repo.update()
  end

  def delete_machine(%Machine{} = machine) do
    Repo.delete(machine)
  end

  def change_machine(%Machine{} = machine) do
    Machine.changeset(machine, %{id: next_machine_id()})
  end

  def next_machine_id do
    last_id = get_last_machine.id
    last_id_int = String.to_integer(last_id)

    zero_complete("#{last_id_int + 1}")
  end

  defp get_last_machine do
    query = from m in Machine,
    order_by: [desc: m.id],
    limit: 1

    Repo.one(query)
  end

  defp zero_complete(<<four_str :: binary-size(4)>>) do
    "000" <> four_str
  end

  defp zero_complete(<<five_str :: binary-size(5)>>) do
    "00" <> five_str
  end

  defp post_machine_to_teamplace(%{valid?: false} = changeset), do: changeset

  defp post_machine_to_teamplace(changeset) do
    data =
      Ecto.Changeset.apply_changes(changeset)
      |> machine_to_teamplace_format

    credentials = Application.get_env(:teamplace, :credentials)

    case Teamplace.post_data(credentials, "maquina", data) do
      {:ok, _ } -> changeset
      {:error, _ } -> Ecto.Changeset.add_error(changeset, :name, "No se pudo crear en Teamplace")
    end
  end

  defp machine_to_teamplace_format(%Machine{id: id, name: name}) do
    %Teamplace.Maquina{Codigo: id, Nombre: name, BienDeUsoID: "GEN"}
    |> Poison.encode!
  end
end
