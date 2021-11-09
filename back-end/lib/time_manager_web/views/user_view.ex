defmodule TodolistWeb.UserView do
  use TodolistWeb, :view
  alias TodolistWeb.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      username: user.username,
      password: user.password,
      mail: user.mail,
      role: user.role,
      firstname: user.firstname,
      lastname: user.lastname
    }
  end
end
