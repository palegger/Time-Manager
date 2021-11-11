defmodule Todolist.Repo.Migrations.CreateTeams do
  use Ecto.Migration

  def change do
    create table(:teams) do
      add :name, :string
      add :managerID, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:teams, [:managerID])
  end
end
