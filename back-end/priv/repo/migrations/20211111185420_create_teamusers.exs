defmodule Todolist.Repo.Migrations.CreateTeamusers do
  use Ecto.Migration

  def change do
    create table(:teamusers) do
      add :userID, references(:users, on_delete: :nothing), primary_key: true
      add :teamID, references(:teams, on_delete: :nothing), primary_key: true

      timestamps()
    end

    create unique_index(:teamusers, [:userID, :teamID])
  end
end
