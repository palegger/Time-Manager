defmodule Todolist.Repo.Migrations.CreateClocks do
  use Ecto.Migration

  def change do
    create table(:clocks) do
      add :start, :naive_datetime
      add :status, :boolean, default: false, null: false
      add :userID, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:clocks, [:userID])
  end
end
