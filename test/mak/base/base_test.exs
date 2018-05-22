defmodule Mak.BaseTest do
  use Mak.DataCase

  alias Mak.Base

  describe "machines" do
    alias Mak.Base.Machine

    @valid_attrs %{code: "some code", desc: "some desc", name: "some name"}
    @update_attrs %{code: "some updated code", desc: "some updated desc", name: "some updated name"}
    @invalid_attrs %{code: nil, desc: nil, name: nil}

    def machine_fixture(attrs \\ %{}) do
      {:ok, machine} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Base.create_machine()

      machine
    end

    test "list_machines/0 returns all machines" do
      machine = machine_fixture()
      assert Base.list_machines() == [machine]
    end

    test "get_machine!/1 returns the machine with given id" do
      machine = machine_fixture()
      assert Base.get_machine!(machine.id) == machine
    end

    test "create_machine/1 with valid data creates a machine" do
      assert {:ok, %Machine{} = machine} = Base.create_machine(@valid_attrs)
      assert machine.code == "some code"
      assert machine.desc == "some desc"
      assert machine.name == "some name"
    end

    test "create_machine/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Base.create_machine(@invalid_attrs)
    end

    test "update_machine/2 with valid data updates the machine" do
      machine = machine_fixture()
      assert {:ok, machine} = Base.update_machine(machine, @update_attrs)
      assert %Machine{} = machine
      assert machine.code == "some updated code"
      assert machine.desc == "some updated desc"
      assert machine.name == "some updated name"
    end

    test "update_machine/2 with invalid data returns error changeset" do
      machine = machine_fixture()
      assert {:error, %Ecto.Changeset{}} = Base.update_machine(machine, @invalid_attrs)
      assert machine == Base.get_machine!(machine.id)
    end

    test "delete_machine/1 deletes the machine" do
      machine = machine_fixture()
      assert {:ok, %Machine{}} = Base.delete_machine(machine)
      assert_raise Ecto.NoResultsError, fn -> Base.get_machine!(machine.id) end
    end

    test "change_machine/1 returns a machine changeset" do
      machine = machine_fixture()
      assert %Ecto.Changeset{} = Base.change_machine(machine)
    end
  end
end
