defmodule Todolist.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string
      add :password, :string
      add :mail, :string
      add :role, :integer
      add :firstname, :string
      add :lastname, :string

      timestamps()
    end
    create unique_index(:users, [:username, :mail])
  end
end
