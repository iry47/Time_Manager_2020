defmodule TimeManager.Repo.Migrations.CreateTeamusers do
  use Ecto.Migration

  def change do
    create table(:teamusers) do
      add :user, references(:users, on_delete: :nothing)
      add :team, references(:teams, on_delete: :nothing)

      timestamps()
    end
  end
     
end