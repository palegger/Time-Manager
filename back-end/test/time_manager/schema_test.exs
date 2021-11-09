defmodule Todolist.SchemaTest do
  use Todolist.DataCase

  alias Todolist.Schema

  describe "users" do
    alias Todolist.Schema.User

    import Todolist.SchemaFixtures

    @invalid_attrs %{firstname: nil, lastname: nil, mail: nil, password: nil, role: nil, username: nil}

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Schema.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Schema.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{firstname: "some firstname", lastname: "some lastname", mail: "some mail", password: "some password", role: 42, username: "some username"}

      assert {:ok, %User{} = user} = Schema.create_user(valid_attrs)
      assert user.firstname == "some firstname"
      assert user.lastname == "some lastname"
      assert user.mail == "some mail"
      assert user.password == "some password"
      assert user.role == 42
      assert user.username == "some username"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Schema.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      update_attrs = %{firstname: "some updated firstname", lastname: "some updated lastname", mail: "some updated mail", password: "some updated password", role: 43, username: "some updated username"}

      assert {:ok, %User{} = user} = Schema.update_user(user, update_attrs)
      assert user.firstname == "some updated firstname"
      assert user.lastname == "some updated lastname"
      assert user.mail == "some updated mail"
      assert user.password == "some updated password"
      assert user.role == 43
      assert user.username == "some updated username"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Schema.update_user(user, @invalid_attrs)
      assert user == Schema.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Schema.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Schema.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Schema.change_user(user)
    end
  end

  describe "teams" do
    alias Todolist.Schema.Team

    import Todolist.SchemaFixtures

    @invalid_attrs %{}

    test "list_teams/0 returns all teams" do
      team = team_fixture()
      assert Schema.list_teams() == [team]
    end

    test "get_team!/1 returns the team with given id" do
      team = team_fixture()
      assert Schema.get_team!(team.id) == team
    end

    test "create_team/1 with valid data creates a team" do
      valid_attrs = %{}

      assert {:ok, %Team{} = team} = Schema.create_team(valid_attrs)
    end

    test "create_team/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Schema.create_team(@invalid_attrs)
    end

    test "update_team/2 with valid data updates the team" do
      team = team_fixture()
      update_attrs = %{}

      assert {:ok, %Team{} = team} = Schema.update_team(team, update_attrs)
    end

    test "update_team/2 with invalid data returns error changeset" do
      team = team_fixture()
      assert {:error, %Ecto.Changeset{}} = Schema.update_team(team, @invalid_attrs)
      assert team == Schema.get_team!(team.id)
    end

    test "delete_team/1 deletes the team" do
      team = team_fixture()
      assert {:ok, %Team{}} = Schema.delete_team(team)
      assert_raise Ecto.NoResultsError, fn -> Schema.get_team!(team.id) end
    end

    test "change_team/1 returns a team changeset" do
      team = team_fixture()
      assert %Ecto.Changeset{} = Schema.change_team(team)
    end
  end

  describe "teamusers" do
    alias Todolist.Schema.Teamuser

    import Todolist.SchemaFixtures

    @invalid_attrs %{}

    test "list_teamusers/0 returns all teamusers" do
      teamuser = teamuser_fixture()
      assert Schema.list_teamusers() == [teamuser]
    end

    test "get_teamuser!/1 returns the teamuser with given id" do
      teamuser = teamuser_fixture()
      assert Schema.get_teamuser!(teamuser.id) == teamuser
    end

    test "create_teamuser/1 with valid data creates a teamuser" do
      valid_attrs = %{}

      assert {:ok, %Teamuser{} = teamuser} = Schema.create_teamuser(valid_attrs)
    end

    test "create_teamuser/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Schema.create_teamuser(@invalid_attrs)
    end

    test "update_teamuser/2 with valid data updates the teamuser" do
      teamuser = teamuser_fixture()
      update_attrs = %{}

      assert {:ok, %Teamuser{} = teamuser} = Schema.update_teamuser(teamuser, update_attrs)
    end

    test "update_teamuser/2 with invalid data returns error changeset" do
      teamuser = teamuser_fixture()
      assert {:error, %Ecto.Changeset{}} = Schema.update_teamuser(teamuser, @invalid_attrs)
      assert teamuser == Schema.get_teamuser!(teamuser.id)
    end

    test "delete_teamuser/1 deletes the teamuser" do
      teamuser = teamuser_fixture()
      assert {:ok, %Teamuser{}} = Schema.delete_teamuser(teamuser)
      assert_raise Ecto.NoResultsError, fn -> Schema.get_teamuser!(teamuser.id) end
    end

    test "change_teamuser/1 returns a teamuser changeset" do
      teamuser = teamuser_fixture()
      assert %Ecto.Changeset{} = Schema.change_teamuser(teamuser)
    end
  end

  describe "workingtimes" do
    alias Todolist.Schema.Workingtime

    import Todolist.SchemaFixtures

    @invalid_attrs %{start: nil, stop: nil}

    test "list_workingtimes/0 returns all workingtimes" do
      workingtime = workingtime_fixture()
      assert Schema.list_workingtimes() == [workingtime]
    end

    test "get_workingtime!/1 returns the workingtime with given id" do
      workingtime = workingtime_fixture()
      assert Schema.get_workingtime!(workingtime.id) == workingtime
    end

    test "create_workingtime/1 with valid data creates a workingtime" do
      valid_attrs = %{start: ~N[2021-11-08 13:22:00], stop: ~N[2021-11-08 13:22:00]}

      assert {:ok, %Workingtime{} = workingtime} = Schema.create_workingtime(valid_attrs)
      assert workingtime.start == ~N[2021-11-08 13:22:00]
      assert workingtime.stop == ~N[2021-11-08 13:22:00]
    end

    test "create_workingtime/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Schema.create_workingtime(@invalid_attrs)
    end

    test "update_workingtime/2 with valid data updates the workingtime" do
      workingtime = workingtime_fixture()
      update_attrs = %{start: ~N[2021-11-09 13:22:00], stop: ~N[2021-11-09 13:22:00]}

      assert {:ok, %Workingtime{} = workingtime} = Schema.update_workingtime(workingtime, update_attrs)
      assert workingtime.start == ~N[2021-11-09 13:22:00]
      assert workingtime.stop == ~N[2021-11-09 13:22:00]
    end

    test "update_workingtime/2 with invalid data returns error changeset" do
      workingtime = workingtime_fixture()
      assert {:error, %Ecto.Changeset{}} = Schema.update_workingtime(workingtime, @invalid_attrs)
      assert workingtime == Schema.get_workingtime!(workingtime.id)
    end

    test "delete_workingtime/1 deletes the workingtime" do
      workingtime = workingtime_fixture()
      assert {:ok, %Workingtime{}} = Schema.delete_workingtime(workingtime)
      assert_raise Ecto.NoResultsError, fn -> Schema.get_workingtime!(workingtime.id) end
    end

    test "change_workingtime/1 returns a workingtime changeset" do
      workingtime = workingtime_fixture()
      assert %Ecto.Changeset{} = Schema.change_workingtime(workingtime)
    end
  end

  describe "clocks" do
    alias Todolist.Schema.Clock

    import Todolist.SchemaFixtures

    @invalid_attrs %{start: nil, status: nil}

    test "list_clocks/0 returns all clocks" do
      clock = clock_fixture()
      assert Schema.list_clocks() == [clock]
    end

    test "get_clock!/1 returns the clock with given id" do
      clock = clock_fixture()
      assert Schema.get_clock!(clock.id) == clock
    end

    test "create_clock/1 with valid data creates a clock" do
      valid_attrs = %{start: ~N[2021-11-08 13:24:00], status: true}

      assert {:ok, %Clock{} = clock} = Schema.create_clock(valid_attrs)
      assert clock.start == ~N[2021-11-08 13:24:00]
      assert clock.status == true
    end

    test "create_clock/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Schema.create_clock(@invalid_attrs)
    end

    test "update_clock/2 with valid data updates the clock" do
      clock = clock_fixture()
      update_attrs = %{start: ~N[2021-11-09 13:24:00], status: false}

      assert {:ok, %Clock{} = clock} = Schema.update_clock(clock, update_attrs)
      assert clock.start == ~N[2021-11-09 13:24:00]
      assert clock.status == false
    end

    test "update_clock/2 with invalid data returns error changeset" do
      clock = clock_fixture()
      assert {:error, %Ecto.Changeset{}} = Schema.update_clock(clock, @invalid_attrs)
      assert clock == Schema.get_clock!(clock.id)
    end

    test "delete_clock/1 deletes the clock" do
      clock = clock_fixture()
      assert {:ok, %Clock{}} = Schema.delete_clock(clock)
      assert_raise Ecto.NoResultsError, fn -> Schema.get_clock!(clock.id) end
    end

    test "change_clock/1 returns a clock changeset" do
      clock = clock_fixture()
      assert %Ecto.Changeset{} = Schema.change_clock(clock)
    end
  end
end
