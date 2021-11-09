defmodule TodolistWeb.TeamuserController do
  use TodolistWeb, :controller

  alias Todolist.Schema
  alias Todolist.Schema.Teamuser

  action_fallback TodolistWeb.FallbackController

  def index(conn, _params) do
    teamusers = Schema.list_teamusers()
    render(conn, "index.json", teamusers: teamusers)
  end

  def create(conn, %{"teamuser" => teamuser_params}) do
    with {:ok, %Teamuser{} = teamuser} <- Schema.create_teamuser(teamuser_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.teamuser_path(conn, :show, teamuser))
      |> render("show.json", teamuser: teamuser)
    end
  end

  def show(conn, %{"id" => id}) do
    teamuser = Schema.get_teamuser!(id)
    render(conn, "show.json", teamuser: teamuser)
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
