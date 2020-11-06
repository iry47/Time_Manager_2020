defmodule TimeManager.Accounts.WidgetUser do
  use Ecto.Schema
  import Ecto.Changeset

  schema "widgetusers" do
    field :param_one, :string, default: "default"
    field :param_two, :string, default: "default"
    field :value_one, :float, default: 0.0
    field :value_two, :float, default: 0.0
    field :x, :integer, default: 0
    field :y, :integer, default: 0
    field :widget, :id
    field :user, :id

    timestamps()
  end

  @doc false
  def changeset(widget_user, attrs) do
    widget_user
    |> cast(attrs, [:x, :y, :param_one, :param_two, :value_one, :value_two, :user, :widget])
    |> validate_required([:x, :y, :param_one, :param_two, :value_one, :value_two, :user, :widget])
  end
end
