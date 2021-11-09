defmodule Todolist.Schema.Clock do
  use Ecto.Schema
  import Ecto.Changeset

  schema "clocks" do
    field :start, :naive_datetime
    field :status, :boolean, default: false
    field :userID, :id

    timestamps()
  end

  @doc false
  def changeset(clock, attrs) do
    clock
    |> cast(attrs, [:start, :status, :userID])
    |> validate_required([:start, :status, :userID])
  end
end
