defmodule TimeManagerWeb.WidgetView do
  use TimeManagerWeb, :view
  alias TimeManagerWeb.WidgetView

  def render("index.json", %{widgets: widgets}) do
    render_many(widgets, WidgetView, "widget.json")
  end

  def render("show.json", %{widget: widget}) do
    render_one(widget, WidgetView, "widget.json")
  end

  def render("widget.json", %{widget: widget}) do
    %{id: widget.id,
      name: widget.name,
      description: widget.description}
  end
end
