defmodule TimeManagerWeb.ClockView do
  use TimeManagerWeb, :view
  alias TimeManagerWeb.ClockView

  def render("index.json", %{clocks: clocks}) do
    render_many(clocks, ClockView, "clock.json")
  end

  def render("show.json", %{clock: clock}) do
    render_one(clock, ClockView, "clock.json")
  end

  def render("clock.json", %{clock: clock}) do
    %{id: clock.id,
      time: clock.time,
      status: clock.status}
  end
end
