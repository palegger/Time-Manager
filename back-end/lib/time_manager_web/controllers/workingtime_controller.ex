defmodule TodolistWeb.WorkingtimeController do
  use TodolistWeb, :controller

  alias Todolist.Schema
  alias Todolist.Schema.Workingtime

  action_fallback TodolistWeb.FallbackController

  def index(conn, _params) do
    workingtimes = Schema.list_workingtimes()
    render(conn, "index.json", workingtimes: workingtimes)
  end

  def create(conn, %{"working_time" => working_time_params, "userID" => userId}) do
    id = to_string(conn.assigns[:tokenUserID])

    cond do
      id == userId ->
        working_time_params_new = Map.put_new(working_time_params, "userID", String.to_integer(userId))
        with {:ok, %Workingtime{} = working_time} <- Schema.create_workingtime(working_time_params_new) do
          conn
          |> put_status(:created)
          |> put_resp_header("location", Routes.workingtime_path(conn, :show, working_time))
          |> render("show.json", workingtime: working_time)
        end
      true ->
        Plug.Conn.send_resp(conn, 401, "")
    end


  end

  def show(conn, %{"id" => id}) do
    role = conn.assigns[:tokenRole]
    userid = to_string(conn.assigns[:tokenUserID])
    wtID = Schema.get_workingtime_userID(id);
    teamID = Schema.get_teamID(userid);
    manager = Schema.get_team_manager_id(List.first(teamID));

    cond do
      role == 2 ->
        workingtime = Schema.get_workingtime!(id)
        render(conn, "show.json", workingtime: workingtime)
      role == 1 && List.first(manager) == userid ->
        workingtime = Schema.get_workingtime!(id)
        render(conn, "show.json", workingtime: workingtime)

      userid == List.first(wtID) ->
        workingtime = Schema.get_workingtime!(id)
        render(conn, "show.json", workingtime: workingtime)
      true ->
        Plug.Conn.send_resp(conn, 401, "")
    end
  end

  def update(conn, %{"id" => id, "working_time" => workingtime_params}) do
    workingtime = Schema.get_workingtime!(id)

    with {:ok, %Workingtime{} = workingtime} <- Schema.update_workingtime(workingtime, workingtime_params) do
      render(conn, "show.json", workingtime: workingtime)
    end
  end

  def delete(conn, %{"id" => id}) do
    role = conn.assigns[:tokenRole]
    userid = to_string(conn.assigns[:tokenUserID])
    teamID = Schema.get_teamID(userid);
    manager = Schema.get_team_manager_id(List.first(teamID));

    cond do
      role == 2 ->
        workingtime = Schema.get_workingtime!(id)
        with {:ok, %Workingtime{}} <- Schema.delete_workingtime(workingtime) do
          send_resp(conn, :no_content, "")
        end
      role == 1 && List.first(manager) == userid ->
        workingtime = Schema.get_workingtime!(id)
        with {:ok, %Workingtime{}} <- Schema.delete_workingtime(workingtime) do
          send_resp(conn, :no_content, "")
        end
      true ->
        Plug.Conn.send_resp(conn, 401, "")
    end

    workingtime = Schema.get_workingtime!(id)

    with {:ok, %Workingtime{}} <- Schema.delete_workingtime(workingtime) do
      send_resp(conn, :no_content, "")
    end
  end


  def indexperiod(conn, %{"userID" => userId, "start" => startDT, "end" => endDT}) do
    role = conn.assigns[:tokenRole];
    id = to_string(conn.assigns[:tokenUserID]);
    teamID = Schema.get_teamID(id);
    manager = Schema.get_team_manager_id(List.first(teamID));

    if(is_nil(manager)) do
      workingtimes = Schema.get_working_time_list_period(userId, startDT, endDT);
      render(conn, "index.json", workingtimes: workingtimes)
    else
      cond do
        role == 2 ->
          workingtimes = Schema.get_working_time_list_period(userId, startDT, endDT);
          render(conn, "index.json", workingtimes: workingtimes)
        role == 1 && List.first(manager) == id ->
          workingtimes = Schema.get_working_time_list_period(userId, startDT, endDT);
          render(conn, "index.json", workingtimes: workingtimes)
        userId == id ->
          workingtimes = Schema.get_working_time_list_period(userId, startDT, endDT);
          render(conn, "index.json", workingtimes: workingtimes)
        true ->
          Plug.Conn.send_resp(conn, 401, "")
      end
    end
  end
end
