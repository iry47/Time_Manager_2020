defmodule TimeManagerWeb.WidgetUserView do
  use TimeManagerWeb, :view
  alias TimeManagerWeb.WidgetUserView

  def render("index.json", %{widgetusers: widgetusers}) do
    %{data: render_many(widgetusers, WidgetUserView, "widget_user.json")}
  end

  def render("show.json", %{widget_user: widget_user}) do
    %{data: render_one(widget_user, WidgetUserView, "widget_user.json")}
  end

  def render("widget_user.json", %{widget_user: widget_user}) do
    %{id: widget_user.id,
      x: widget_user.x,
      y: widget_user.y,
      param_one: widget_user.param_one,
      param_two: widget_user.param_two,
      value_one: widget_user.value_one,
      value_two: widget_user.value_two}
  end
end
