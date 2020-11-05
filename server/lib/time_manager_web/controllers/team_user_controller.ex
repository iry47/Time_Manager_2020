defmodule TimeManagerWeb.TeamUserController do
  use TimeManagerWeb, :controller

  alias TimeManager.Accounts
  alias TimeManager.Accounts.TeamUser

  action_fallback TimeManagerWeb.FallbackController

  def index(conn, _params) do
    teamusers = Accounts.list_teamusers()
    render(conn, "index.json", teamusers: teamusers)
  end

  def create(conn, %{"team_user" => team_user_params}) do
    with {:ok, %TeamUser{} = team_user} <- Accounts.create_team_user(team_user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.team_user_path(conn, :show, team_user))
      |> render("show.json", team_user: team_user)
    end
  end

  def show(conn, %{"id" => id}) do
    team_user = Accounts.get_team_user!(id)
    render(conn, "show.json", team_user: team_user)
  end

  def update(conn, %{"id" => id, "team_user" => team_user_params}) do
    team_user = Accounts.get_team_user!(id)

    with {:ok, %TeamUser{} = team_user} <- Accounts.update_team_user(team_user, team_user_params) do
      render(conn, "show.json", team_user: team_user)
    end
  end

  def delete(conn, %{"id" => id}) do
    team_user = Accounts.get_team_user!(id)

    with {:ok, %TeamUser{}} <- Accounts.delete_team_user(team_user) do
      send_resp(conn, :no_content, "")
    end
  end
end
