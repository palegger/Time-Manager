defmodule TodolistWeb.TeamuserView do
  use TodolistWeb, :view
  alias TodolistWeb.TeamuserView

  def render("index.json", %{teamusers: teamusers}) do
    %{data: render_many(teamusers, TeamuserView, "teamuser.json")}
  end

  def render("show.json", %{teamuser: teamuser}) do
    %{data: render_one(teamuser, TeamuserView, "teamuser.json")}
  end

  def render("teamuser.json", %{teamuser: teamuser}) do
    %{
      id: teamuser.id
    }
  end
end
