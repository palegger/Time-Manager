defmodule Todolist.Schema.Workingtime do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, only: [from: 2]

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

  def getByUsernameAndEmail(query, userId, startDT, endDT) do
    from workingtimes in query,
    where: workingtimes.start >= ^startDT and workingtimes.stop <= ^endDT and workingtimes.userID == ^userId,
    select: %{start: workingtimes.start, stop: workingtimes.stop, id: workingtimes.id}
  end
end
