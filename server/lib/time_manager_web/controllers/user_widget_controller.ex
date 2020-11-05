defmodule TimeManagerWeb.UserWidgetController do
  use TimeManagerWeb, :controller

  alias TimeManager.Accounts
  alias TimeManager.Accounts.Widget

  action_fallback TimeManagerWeb.FallbackController

  def show(conn, %{"user" => userid}) do
    widget_user = Accounts.get_widget_user!(userid)
    render(conn, "show.json", widget_user: widget_user)
  end

end