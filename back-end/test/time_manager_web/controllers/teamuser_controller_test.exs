defmodule TodolistWeb.TeamuserControllerTest do
  use TodolistWeb.ConnCase

  import Todolist.SchemaFixtures

  alias Todolist.Schema.Teamuser

  @create_attrs %{

  }
  @update_attrs %{

  }
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all teamusers", %{conn: conn} do
      conn = get(conn, Routes.teamuser_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create teamuser" do
    test "renders teamuser when data is valid", %{conn: conn} do
      conn = post(conn, Routes.teamuser_path(conn, :create), teamuser: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.teamuser_path(conn, :show, id))

      assert %{
               "id" => ^id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.teamuser_path(conn, :create), teamuser: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update teamuser" do
    setup [:create_teamuser]

    test "renders teamuser when data is valid", %{conn: conn, teamuser: %Teamuser{id: id} = teamuser} do
      conn = put(conn, Routes.teamuser_path(conn, :update, teamuser), teamuser: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.teamuser_path(conn, :show, id))

      assert %{
               "id" => ^id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, teamuser: teamuser} do
      conn = put(conn, Routes.teamuser_path(conn, :update, teamuser), teamuser: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete teamuser" do
    setup [:create_teamuser]

    test "deletes chosen teamuser", %{conn: conn, teamuser: teamuser} do
      conn = delete(conn, Routes.teamuser_path(conn, :delete, teamuser))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.teamuser_path(conn, :show, teamuser))
      end
    end
  end

  defp create_teamuser(_) do
    teamuser = teamuser_fixture()
    %{teamuser: teamuser}
  end
end
