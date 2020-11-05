defmodule TimeManagerWeb.UserController do
  use TimeManagerWeb, :controller

  alias TimeManager.Accounts
  alias TimeManager.Accounts.User

  action_fallback TimeManagerWeb.FallbackController

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, user_params) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def show(conn, _params) do
    user = TimeManagerWeb.Authentication.get_current_account(conn)
    render(conn, :show, user: user)
  end

  def update(conn, user_params) do
    user = Accounts.get_user!(user_params["id"])

    with {:ok, %User{} = user} <- Accounts.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{}} <- Accounts.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end

  # def sign_in(conn, %{"user" => user_params}) do
  #   case authenticate_user(user) do
  #     {:ok, user} ->
  #       render(conn, "show.json", user: user)
  #     {:error, message} ->
  #       conn
  #       |> put_status(:unauthorized)
  #       |> render(TimeManager.ErrorView, "401.json", message: message)
  #   end
  # end

  # defp authenticate_user(user) do

  # end
end
