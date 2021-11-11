defmodule Todolist.Repo.Migrations.CreateTeamusers do
  use Ecto.Migration

  def change do
    create table(:teamusers, primary_key: false) do
      add :userID, references(:users, on_delete: :nothing), primary_key: true
      add :teamID, references(:teams, on_delete: :nothing), primary_key: true

      timestamps()
    end

    create index(:teamusers, [:userID])
    create index(:teamusers, [:teamID])
  end
end
