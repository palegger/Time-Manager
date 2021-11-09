defmodule Todolist.Schema.Workingtime do
  use Ecto.Schema
  import Ecto.Changeset

  schema "workingtimes" do
    field :start, :naive_datetime
    field :stop, :naive_datetime
    field :userID, :id

    timestamps()
  end

  @doc false
  def changeset(workingtime, attrs) do
    workingtime
    |> cast(attrs, [:start, :stop, :userID])
    |> validate_required([:start, :stop, :userID])
  end
end
