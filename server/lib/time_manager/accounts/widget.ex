defmodule TimeManager.Accounts.Widget do
  use Ecto.Schema
  import Ecto.Changeset

  schema "widgets" do
    field :description, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(widget, attrs) do
    widget
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
  end
end
