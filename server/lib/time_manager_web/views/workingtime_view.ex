defmodule TimeManagerWeb.WorkingtimeView do
  use TimeManagerWeb, :view
  alias TimeManagerWeb.WorkingtimeView

  def render("index.json", %{workingtimes: workingtimes}) do
    render_many(workingtimes, WorkingtimeView, "workingtime.json")
  end

  def render("show.json", %{workingtime: workingtime}) do
    render_one(workingtime, WorkingtimeView, "workingtime.json")
  end

  def render("workingtime.json", %{workingtime: workingtime}) do
    %{id: workingtime.id,
      start: workingtime.start,
      end: workingtime.end,
      user: workingtime.user}
  end
end
