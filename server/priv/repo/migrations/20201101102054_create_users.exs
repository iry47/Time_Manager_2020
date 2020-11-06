defmodule TimeManager.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :hash, :string
      add :salt, :string
      add :admin, :boolean, default: false, null: false
      add :manager, :boolean, default: false, null: false
      add :gridster, :boolean, default: false, null: false
      add :firstname, :string, default: ""
      add :lastname, :string, default: ""

      timestamps()
    end

    create unique_index(:users, [:email])
  end
end
