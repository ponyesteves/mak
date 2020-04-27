defmodule Mak.Base do
  @moduledoc """
  The Base context.
  """

  import Ecto.Query, warn: false
  alias Mak.Repo

  alias Mak.Base.Machine

  @doc """
  Returns the list of machines.

  ## Examples

      iex> list_machines()
      [%Machine{}, ...]

  """
  def list_machines(code_name \\ "") do
    query = "%#{code_name}%"

    Machine
    |> where([m], ilike(m.id, ^query) or ilike(m.name, ^query))
    |> limit(20)
    |> Repo.all()
  end

  @doc """
  Gets a single machine.

  Raises `Ecto.NoResultsError` if the Machine does not exist.

  ## Examples

      iex> get_machine!(123)
      %Machine{}

      iex> get_machine!(456)
      ** (Ecto.NoResultsError)

  """
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

  @doc """
  Creates a machine.

  ## Examples

      iex> create_machine(%{field: value})
      {:ok, %Machine{}}

      iex> create_machine(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_machine(attrs \\ %{}) do
    %Machine{}
    |> Machine.changeset(attrs)
    |> post_machine_to_teamplace()
    |> Repo.insert()
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

  def upsert_machine(attrs \\ %{}) do
    case Repo.get(Machine, attrs["id"]) do
      nil ->
        create_machine(attrs)

      machine ->
        update_machine(machine, attrs)
    end
  end

  @doc """
  Updates a machine.

  ## Examples

      iex> update_machine(machine, %{field: new_value})
      {:ok, %Machine{}}

      iex> update_machine(machine, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_machine(%Machine{} = machine, attrs) do
    machine
    |> Machine.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Machine.

  ## Examples

      iex> delete_machine(machine)
      {:ok, %Machine{}}

      iex> delete_machine(machine)
      {:error, %Ecto.Changeset{}}

  """
  def delete_machine(%Machine{} = machine) do
    Repo.delete(machine)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking machine changes.

  ## Examples

      iex> change_machine(machine)
      %Ecto.Changeset{source: %Machine{}}

  """
  def change_machine(%Machine{} = machine) do
    Machine.changeset(machine, %{})
  end
end
