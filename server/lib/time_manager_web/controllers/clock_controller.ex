defmodule TimeManagerWeb.ClockController do
  use TimeManagerWeb, :controller

  alias TimeManager.Timer
  alias TimeManager.Timer.Clock

  action_fallback TimeManagerWeb.FallbackController

  def index(conn, _params) do
    clocks = Timer.list_clocks()
    render(conn, "index.json", clocks: clocks)
  end

  def create(conn, params) do

    clock_params = params["clock"]
    clock_params = Map.put_new(clock_params, "user", String.to_integer(params["user"]))
    #IO.puts clock_params
    case Timer.create_clock(clock_params) do
      {:ok, %Clock{} = clock} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", Routes.clock_path(conn, :show, clock: clock))
        |> render("show.json", clock: clock)
      {:error, message} ->
        conn
        |> put_status(:unauthorized)
        |> render(TimeManager.ErrorView, "401.json", message: message)

    end
  end

  def show(conn, %{"id" => id}) do
    clock = Timer.get_clock!(id)
    render(conn, "show.json", clock: clock)
  end

  def update(conn, %{"id" => id, "clock" => clock_params}) do
    clock = Timer.get_clock!(id)

    with {:ok, %Clock{} = clock} <- Timer.update_clock(clock, clock_params) do
      render(conn, "show.json", clock: clock)
    end
  end

  def delete(conn, %{"id" => id}) do
    clock = Timer.get_clock!(id)

    with {:ok, %Clock{}} <- Timer.delete_clock(clock) do
      send_resp(conn, :no_content, "")
    end
  end
end
