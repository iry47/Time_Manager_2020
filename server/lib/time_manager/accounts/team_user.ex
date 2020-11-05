defmodule TimeManager.Accounts.TeamUser do
  use Ecto.Schema
  import Ecto.Changeset

  schema "teamusers" do
    field :user, :id
    field :team, :id

    timestamps()
  end

  @doc false
  def changeset(team_user, attrs) do
    team_user
    |> cast(attrs, [:team, :user])
    |> validate_required([:team, :user])
  end
end
