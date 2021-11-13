defmodule TodolistWeb.TeamuserController do
  use TodolistWeb, :controller

  alias Todolist.Schema
  alias Todolist.Schema.Teamuser

  action_fallback TodolistWeb.FallbackController

  def index(conn, _params) do
    teamusers = Schema.list_teamusers()
    render(conn, "index.json", teamusers: teamusers)
  end

  def create(conn, %{"teamid" => teamID , "userid" => userID}) do

    teamuser_params = %{"teamID" => teamID, "userID" => userID}

    with {:ok, %Teamuser{} = _teamuser} <- Schema.create_teamuser(teamuser_params) do
      Plug.Conn.send_resp(conn, 201, "")
    end
  end

  def show(conn, %{"id" => id}) do
    teamuser = Schema.get_teamuser!(id)
    render(conn, "show.json", teamuser: teamuser)
  end

  def indexTeam(conn, %{"teamid" => id}) do
    teamusers = Schema.get_teamusers_by_team(id)
    render(conn, "index.json", teamusers: teamusers)
  end

  def update(conn, %{"id" => id, "teamuser" => teamuser_params}) do
    teamuser = Schema.get_teamuser!(id)
    with {:ok, %Teamuser{} = teamuser} <- Schema.update_teamuser(teamuser, teamuser_params) do
      render(conn, "show.json", teamuser: teamuser)
    end
  end

  def delete(conn, %{"id" => id}) do
    teamuser = Schema.get_teamuser!(id)

    with {:ok, %Teamuser{}} <- Schema.delete_teamuser(teamuser) do
      send_resp(conn, :no_content, "")
    end
  end
end
