defmodule TodolistWeb.ClockController do
  use TodolistWeb, :controller

  alias Todolist.Schema
  alias Todolist.Schema.Clock

  action_fallback TodolistWeb.FallbackController

  def index(conn, _params) do
    clocks = Schema.list_clocks()
    render(conn, "index.json", clocks: clocks)
  end

  def create(conn, %{"clock" => clock_params}) do
    userid = to_string(conn.assigns[:tokenUserID])

    clock_params_new = Map.put_new(clock_params, "userID", String.to_integer(userid))
    IO.inspect(clock_params_new)
    with {:ok, %Clock{} = clock} <- Schema.create_clock(clock_params_new) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.clock_path(conn, :show, clock))
      |> render("show.json", clock: clock)
    end
  end

  def indexclocks(conn, %{"userID" => userId}) do
    userid = to_string(conn.assigns[:tokenUserID])

    cond do
      userid == userId ->
        clocks = Schema.list_clocks_by_user(userId)
        render(conn, "index.json", clocks: clocks)
      true ->
        Plug.Conn.send_resp(conn, 401, "")
    end
  end

  def show(conn, %{"id" => id}) do
    userid = conn.assigns[:tokenUserID]

    clock = Schema.get_clock!(id)
    IO.inspect(userid)
    IO.inspect(clock)
    cond do
      userid == clock.userID ->
        render(conn, "show.json", clock: clock)
      true ->
        Plug.Conn.send_resp(conn, 401, "")
      end
  end

  def update(conn, %{"id" => id, "clock" => clock_params}) do
    clock = Schema.get_clock!(id)

    with {:ok, %Clock{} = clock} <- Schema.update_clock(clock, clock_params) do
      render(conn, "show.json", clock: clock)
    end
  end

  def delete(conn, %{"id" => id}) do
    clock = Schema.get_clock!(id)

    with {:ok, %Clock{}} <- Schema.delete_clock(clock) do
      send_resp(conn, :no_content, "")
    end
  end
end
