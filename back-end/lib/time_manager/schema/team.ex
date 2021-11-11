defmodule Todolist.Schema.Team do
  use Ecto.Schema
  import Ecto.Changeset

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
end
