defmodule TimeManagerWeb.HomeController do
  use TimeManagerWeb, :controller

  action_fallback TimeManagerWeb.FallbackController

  def show(conn, _params) do
      conn
      |> put_status(:ok)
      render(conn, "show.json", %{})
  end

end
