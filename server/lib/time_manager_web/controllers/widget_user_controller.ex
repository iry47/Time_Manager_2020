defmodule TimeManagerWeb.WidgetUserController do
  use TimeManagerWeb, :controller

  alias TimeManager.Accounts
  alias TimeManager.Accounts.WidgetUser

  action_fallback TimeManagerWeb.FallbackController

  def index(conn, _params) do
    widgetusers = Accounts.list_widgetusers()
    render(conn, "index.json", widgetusers: widgetusers)
  end

  def create(conn, widget_user_params) do
    with {:ok, %WidgetUser{} = widget_user} <- Accounts.create_widget_user(widget_user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.widget_user_path(conn, :show, widget_user))
      |> render("show.json", widget_user: widget_user)
    end
  end

  def show(conn, %{"widgetid" => widgetid}) do
    widget = Accounts.get_widget!(widgetid)
    render(conn, "show.json", widget: widget)
  end

  def update(conn, widget_user_params) do
    widget_user = Accounts.get_widget_user!(widget_user_params["id"])

    with {:ok, %WidgetUser{} = widget_user} <- Accounts.update_widget_user(widget_user, widget_user_params) do
      render(conn, "show.json", widget_user: widget_user)
    end
  end

  def delete(conn, %{"id" => id}) do
    widget_user = Accounts.get_widget_user!(id)

    with {:ok, %WidgetUser{}} <- Accounts.delete_widget_user(widget_user) do
      send_resp(conn, :no_content, "")
    end
  end
end
