defmodule Todolist.Schema.Team do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, only: [from: 2]

  schema "teams" do
    field :name, :string
    field :managerID, :id

    timestamps()
  end

  @doc false
  def changeset(team, attrs) do
    team
    |> cast(attrs, [:name, :managerID])
    |> validate_required([:name, :managerID])
  end

  def getManagerID(query, teamID) do
    from teams in query,
    where: teams.id == ^teamID,
    select: teams.managerID
  end
end
