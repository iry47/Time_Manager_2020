defmodule TimeManager.Repo.Migrations.CreateWidgets do
  use Ecto.Migration

  def change do
    create table(:widgets) do
      add :name, :string
      add :description, :string

      timestamps()
    end

  end
end
