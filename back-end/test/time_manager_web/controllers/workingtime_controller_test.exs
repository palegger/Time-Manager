defmodule TodolistWeb.WorkingtimeControllerTest do
  use TodolistWeb.ConnCase

  import Todolist.SchemaFixtures

  alias Todolist.Schema.Workingtime

  @create_attrs %{
    start: ~N[2021-11-10 18:51:00],
    stop: ~N[2021-11-10 18:51:00]
  }
  @update_attrs %{
    start: ~N[2021-11-11 18:51:00],
    stop: ~N[2021-11-11 18:51:00]
  }
  @invalid_attrs %{start: nil, stop: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all workingtimes", %{conn: conn} do
      conn = get(conn, Routes.workingtime_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create workingtime" do
    test "renders workingtime when data is valid", %{conn: conn} do
      conn = post(conn, Routes.workingtime_path(conn, :create), workingtime: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.workingtime_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "start" => "2021-11-10T18:51:00",
               "stop" => "2021-11-10T18:51:00"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.workingtime_path(conn, :create), workingtime: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update workingtime" do
    setup [:create_workingtime]

    test "renders workingtime when data is valid", %{conn: conn, workingtime: %Workingtime{id: id} = workingtime} do
      conn = put(conn, Routes.workingtime_path(conn, :update, workingtime), workingtime: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.workingtime_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "start" => "2021-11-11T18:51:00",
               "stop" => "2021-11-11T18:51:00"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, workingtime: workingtime} do
      conn = put(conn, Routes.workingtime_path(conn, :update, workingtime), workingtime: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete workingtime" do
    setup [:create_workingtime]

    test "deletes chosen workingtime", %{conn: conn, workingtime: workingtime} do
      conn = delete(conn, Routes.workingtime_path(conn, :delete, workingtime))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.workingtime_path(conn, :show, workingtime))
      end
    end
  end

  defp create_workingtime(_) do
    workingtime = workingtime_fixture()
    %{workingtime: workingtime}
  end
end
