defmodule TodolistWeb.UserController do
  use TodolistWeb, :controller

  alias Todolist.Schema
  alias Todolist.Schema.User

  action_fallback TodolistWeb.FallbackController

  def index(conn, _params) do
    users = Schema.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Schema.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Schema.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Schema.get_user!(id)

    with {:ok, %User{} = user} <- Schema.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Schema.get_user!(id)

    with {:ok, %User{}} <- Schema.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end

  def signin(conn, %{"username" => username, "password" => password}) do
    user = Schema.sign_in(username, password)
    if (user) do
      signer = Joken.Signer.create("HS256", Application.get_env(:joken, :default_signer))
      {:ok, token, _claims} = TodolistWeb.Token.generate_and_sign(%{"username" => username, "role" => user.role}, signer)
      send_resp(conn, 200, token)
    else
      send_resp(conn, 404, "")
    end
  end
end
