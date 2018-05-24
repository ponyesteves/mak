defmodule Mak.TransactionsTest do
  use Mak.DataCase

  alias Mak.Transactions

  describe "types" do
    alias Mak.Transactions.Type

    @valid_attrs %{code: "some code", g: "some g", name: "some name"}
    @update_attrs %{code: "some updated code", g: "some updated g", name: "some updated name"}
    @invalid_attrs %{code: nil, g: nil, name: nil}

    def type_fixture(attrs \\ %{}) do
      {:ok, type} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Transactions.create_type()

      type
    end

    test "list_types/0 returns all types" do
      type = type_fixture()
      assert Transactions.list_types() == [type]
    end

    test "get_type!/1 returns the type with given id" do
      type = type_fixture()
      assert Transactions.get_type!(type.id) == type
    end

    test "create_type/1 with valid data creates a type" do
      assert {:ok, %Type{} = type} = Transactions.create_type(@valid_attrs)
      assert type.code == "some code"
      assert type.g == "some g"
      assert type.name == "some name"
    end

    test "create_type/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Transactions.create_type(@invalid_attrs)
    end

    test "update_type/2 with valid data updates the type" do
      type = type_fixture()
      assert {:ok, type} = Transactions.update_type(type, @update_attrs)
      assert %Type{} = type
      assert type.code == "some updated code"
      assert type.g == "some updated g"
      assert type.name == "some updated name"
    end

    test "update_type/2 with invalid data returns error changeset" do
      type = type_fixture()
      assert {:error, %Ecto.Changeset{}} = Transactions.update_type(type, @invalid_attrs)
      assert type == Transactions.get_type!(type.id)
    end

    test "delete_type/1 deletes the type" do
      type = type_fixture()
      assert {:ok, %Type{}} = Transactions.delete_type(type)
      assert_raise Ecto.NoResultsError, fn -> Transactions.get_type!(type.id) end
    end

    test "change_type/1 returns a type changeset" do
      type = type_fixture()
      assert %Ecto.Changeset{} = Transactions.change_type(type)
    end
  end
end
