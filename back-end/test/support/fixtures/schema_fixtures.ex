defmodule Todolist.SchemaFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Todolist.Schema` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        firstname: "some firstname",
        lastname: "some lastname",
        mail: "some mail",
        password: "some password",
        role: 42,
        username: "some username"
      })
      |> Todolist.Schema.create_user()

    user
  end

  @doc """
  Generate a team.
  """
  def team_fixture(attrs \\ %{}) do
    {:ok, team} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Todolist.Schema.create_team()

    team
  end

  @doc """
  Generate a workingtime.
  """
  def workingtime_fixture(attrs \\ %{}) do
    {:ok, workingtime} =
      attrs
      |> Enum.into(%{
        start: ~N[2021-11-10 18:51:00],
        stop: ~N[2021-11-10 18:51:00]
      })
      |> Todolist.Schema.create_workingtime()

    workingtime
  end

  @doc """
  Generate a clock.
  """
  def clock_fixture(attrs \\ %{}) do
    {:ok, clock} =
      attrs
      |> Enum.into(%{
        start: ~N[2021-11-10 18:51:00],
        status: true
      })
      |> Todolist.Schema.create_clock()

    clock
  end

  @doc """
  Generate a teamuser.
  """
  def teamuser_fixture(attrs \\ %{}) do
    {:ok, teamuser} =
      attrs
      |> Enum.into(%{

      })
      |> Todolist.Schema.create_teamuser()

    teamuser
  end
end
