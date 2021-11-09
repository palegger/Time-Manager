defmodule TodolistWeb.ClockControllerTest do
  use TodolistWeb.ConnCase

  import Todolist.SchemaFixtures

  alias Todolist.Schema.Clock

  @create_attrs %{
    start: ~N[2021-11-08 13:24:00],
    status: true
  }
  @update_attrs %{
    start: ~N[2021-11-09 13:24:00],
    status: false
  }
  @invalid_attrs %{start: nil, status: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all clocks", %{conn: conn} do
      conn = get(conn, Routes.clock_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create clock" do
    test "renders clock when data is valid", %{conn: conn} do
      conn = post(conn, Routes.clock_path(conn, :create), clock: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.clock_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "start" => "2021-11-08T13:24:00",
               "status" => true
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.clock_path(conn, :create), clock: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update clock" do
    setup [:create_clock]

    test "renders clock when data is valid", %{conn: conn, clock: %Clock{id: id} = clock} do
      conn = put(conn, Routes.clock_path(conn, :update, clock), clock: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.clock_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "start" => "2021-11-09T13:24:00",
               "status" => false
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, clock: clock} do
      conn = put(conn, Routes.clock_path(conn, :update, clock), clock: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete clock" do
    setup [:create_clock]

    test "deletes chosen clock", %{conn: conn, clock: clock} do
      conn = delete(conn, Routes.clock_path(conn, :delete, clock))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.clock_path(conn, :show, clock))
      end
    end
  end

  defp create_clock(_) do
    clock = clock_fixture()
    %{clock: clock}
  end
end
