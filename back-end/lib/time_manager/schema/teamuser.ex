defmodule Todolist.Schema.Teamuser do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, only: [from: 2]

  schema "teamusers" do
    field :userID, :integer
    field :teamID, :integer

    timestamps()
  end

  @doc false
  def changeset(teamuser, attrs) do
    teamuser
    |> cast(attrs, [:userID, :teamID])
    |> validate_required([:userID, :teamID])
  end

  def getByTeam(query, teamID) do
    from teamusers in query,
    where: teamusers.teamID == ^teamID,
    select: %{teamID: teamusers.teamID, userID: teamusers.userID, id: teamusers.id}
  end


  def getByUser(query, userID) do
    from teamusers in query,
    where: teamusers.userID == ^userID,
    select: %{teamID: teamusers.teamID, userID: teamusers.userID, id: teamusers.id}
  end


end
