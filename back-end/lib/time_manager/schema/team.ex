defmodule Todolist.Schema.Team do
  use Ecto.Schema
  import Ecto.Changeset

  schema "teams" do
    field :managerID, :id

    timestamps()
  end

  @doc false
  def changeset(team, attrs) do
    team
    |> cast(attrs, [:managerID])
    |> validate_required([:managerID])
  end
end
