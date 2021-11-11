defmodule Todolist.Schema.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :firstname, :string
    field :lastname, :string
    field :mail, :string
    field :password, :string
    field :role, :integer
    field :username, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :password, :mail, :role, :firstname, :lastname])
    |> validate_required([:username, :password, :mail, :role, :firstname, :lastname])
  end
end
