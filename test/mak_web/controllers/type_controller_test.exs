defmodule MakWeb.TypeControllerTest do
  use MakWeb.ConnCase

  alias Mak.Transactions

  @create_attrs %{code: "some code", g: "some g", name: "some name"}
  @update_attrs %{code: "some updated code", g: "some updated g", name: "some updated name"}
  @invalid_attrs %{code: nil, g: nil, name: nil}

  def fixture(:type) do
    {:ok, type} = Transactions.create_type(@create_attrs)
    type
  end

  describe "index" do
    test "lists all types", %{conn: conn} do
      conn = get conn, type_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Types"
    end
  end

  describe "new type" do
    test "renders form", %{conn: conn} do
      conn = get conn, type_path(conn, :new)
      assert html_response(conn, 200) =~ "New Type"
    end
  end

  describe "create type" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, type_path(conn, :create), type: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == type_path(conn, :show, id)

      conn = get conn, type_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Type"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, type_path(conn, :create), type: @invalid_attrs
      assert html_response(conn, 200) =~ "New Type"
    end
  end

  describe "edit type" do
    setup [:create_type]

    test "renders form for editing chosen type", %{conn: conn, type: type} do
      conn = get conn, type_path(conn, :edit, type)
      assert html_response(conn, 200) =~ "Edit Type"
    end
  end

  describe "update type" do
    setup [:create_type]

    test "redirects when data is valid", %{conn: conn, type: type} do
      conn = put conn, type_path(conn, :update, type), type: @update_attrs
      assert redirected_to(conn) == type_path(conn, :show, type)

      conn = get conn, type_path(conn, :show, type)
      assert html_response(conn, 200) =~ "some updated code"
    end

    test "renders errors when data is invalid", %{conn: conn, type: type} do
      conn = put conn, type_path(conn, :update, type), type: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Type"
    end
  end

  describe "delete type" do
    setup [:create_type]

    test "deletes chosen type", %{conn: conn, type: type} do
      conn = delete conn, type_path(conn, :delete, type)
      assert redirected_to(conn) == type_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, type_path(conn, :show, type)
      end
    end
  end

  defp create_type(_) do
    type = fixture(:type)
    {:ok, type: type}
  end
end
