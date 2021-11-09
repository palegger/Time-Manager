defmodule Todolist.Schema.Teamuser do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  schema "teamusers" do
    field :userID, :id, primary_key: true
    field :teamID, :id, primary_key: true

    timestamps()
  end

  @doc false
  def changeset(teamuser, attrs) do
    teamuser
    |> cast(attrs, [:userID, :teamID])
    |> validate_required([:userID, :teamID])
  end
end
