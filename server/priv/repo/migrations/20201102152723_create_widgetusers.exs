defmodule TimeManager.Repo.Migrations.CreateWidgetusers do
  use Ecto.Migration

  def change do
    create table(:widgetusers) do
      add :x, :integer, default: 0, null: false
      add :y, :integer, default: 0, null: false
      add :param_one, :string, default: "default"
      add :param_two, :string, default: "default"
      add :value_one, :float, default: 0.0, null: false
      add :value_two, :float, default: 0.0, null: false
      add :widget, references(:widgets, on_delete: :nothing)
      add :user, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:widgetusers, [:widget])
    create index(:widgetusers, [:user])
  end
end
