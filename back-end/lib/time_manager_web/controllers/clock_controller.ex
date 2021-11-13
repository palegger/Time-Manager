defmodule TodolistWeb.ClockController do
  use TodolistWeb, :controller

  alias Todolist.Schema
  alias Todolist.Schema.Clock

  action_fallback TodolistWeb.FallbackController

  def index(conn, _params) do
    clocks = Schema.list_clocks()
    render(conn, "index.json", clocks: clocks)
  end

  def create(conn, %{"clock" => clock_params, "userID" => userId}) do
    clock_params_new = Map.put_new(clock_params, "userID", String.to_integer(userId))
    IO.inspect(clock_params_new)
    with {:ok, %Clock{} = clock} <- Schema.create_clock(clock_params_new) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.clock_path(conn, :show, clock))
      |> render("show.json", clock: clock)
    end
  end

  def indexclocks(conn, %{"userID" => userId}) do
    clocks = Schema.list_clocks_by_user(userId)
    render(conn, "index.json", clocks: clocks)
  end

  def show(conn, %{"id" => id}) do
    clock = Schema.get_clock!(id)
    render(conn, "show.json", clock: clock)
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
