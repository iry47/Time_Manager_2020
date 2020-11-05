defmodule TimeManagerWeb.TeamUserView do
  use TimeManagerWeb, :view
  alias TimeManagerWeb.TeamUserView

  def render("index.json", %{teamusers: teamusers}) do
    %{data: render_many(teamusers, TeamUserView, "team_user.json")}
  end

  def render("show.json", %{team_user: team_user}) do
    %{data: render_one(team_user, TeamUserView, "team_user.json")}
  end

  def render("team_user.json", %{team_user: team_user}) do
    %{id: team_user.id}
  end
end
