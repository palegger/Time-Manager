defmodule TodolistWeb.TeamController do
  use TodolistWeb, :controller

  alias Todolist.Schema
  alias Todolist.Schema.Team

  action_fallback TodolistWeb.FallbackController

  def index(conn, _params) do
    teams = Schema.list_teams()
    render(conn, "index.json", teams: teams)
  end

  def create(conn, %{"team" => team_params}) do
    with {:ok, %Team{} = team} <- Schema.create_team(team_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.team_path(conn, :show, team))
      |> render("show.json", team: team)
    end
  end

  def show(conn, %{"id" => id}) do
    team = Schema.get_team!(id)
    render(conn, "show.json", team: team)
  end

  def update(conn, %{"id" => id, "team" => team_params}) do
    team = Schema.get_team!(id)

    with {:ok, %Team{} = team} <- Schema.update_team(team, team_params) do
      render(conn, "show.json", team: team)
    end
  end

  def delete(conn, %{"id" => id}) do
    team = Schema.get_team!(id)

    with {:ok, %Team{}} <- Schema.delete_team(team) do
      send_resp(conn, :no_content, "")
    end
  end
end
