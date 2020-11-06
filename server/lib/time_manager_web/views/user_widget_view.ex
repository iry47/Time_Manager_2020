defmodule TimeManagerWeb.UserWidgetView do
  use TimeManagerWeb, :view
  alias TimeManagerWeb.UserWidgetView


  def render("show.json", %{widget_user: widget_user}) do
    render_one(widget_user, UserWidgetView, "widget_user.json")
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
