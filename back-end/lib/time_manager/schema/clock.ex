defmodule Todolist.Schema.Clock do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, only: [from: 2]


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

  def getByUserId(query, userId) do
    from clocks in query,
    where: clocks.userID == ^userId,
    select: %{status: clocks.status, start: clocks.start, id: clocks.id}
  end
end
