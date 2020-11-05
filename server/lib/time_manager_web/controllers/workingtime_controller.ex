defmodule TimeManagerWeb.WorkingtimeController do
  use TimeManagerWeb, :controller

  alias TimeManager.Schedule
  alias TimeManager.Schedule.Workingtime

  action_fallback TimeManagerWeb.FallbackController

  def index(conn, _params) do
    workingtimes = Schedule.list_workingtimes()
    IO.puts workingtimes
    render(conn, "index.json", workingtimes: workingtimes)
  end

  def create(conn, %{"workingtime" => workingtime_params}) do
    with {:ok, %Workingtime{} = workingtime} <- Schedule.create_workingtime(workingtime_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.workingtime_path(conn, :show, workingtime))
      |> render("show.json", workingtimes: workingtime)
    end
  end

  def show(conn, %{"id" => user_id}) do
    workingtimes = Schedule.get_workingtime_by_user!(String.to_integer(user_id))
    # workingtimes = Schedule.Workingtime.changeset(%Workingtime{}, workingtimes)
    render(conn, "index.json", workingtimes: workingtimes)
  end

  def show(conn, %{"userID" => user_id, "workingtimeID" => workingtime_id}) do
    workingtimes = Schedule.get_workingtime_by_user_workingID!(String.to_integer(user_id), String.to_integer(workingtime_id))
    render(conn, "show.json", workingtimes: workingtimes)
  end

  # def show(conn, %{"id" => id}) do
  #   workingtime = Schedule.get_workingtime!(id)
  #   render(conn, "show.json", workingtime: workingtime)
  # end

  def update(conn, %{"id" => id, "workingtime" => workingtime_params}) do
    workingtime = Schedule.get_workingtime!(id)

    with {:ok, %Workingtime{} = workingtime} <- Schedule.update_workingtime(workingtime, workingtime_params) do
      render(conn, "show.json", workingtime: workingtime)
    end
  end

  def delete(conn, %{"id" => id}) do
    workingtime = Schedule.get_workingtime!(id)

    with {:ok, %Workingtime{}} <- Schedule.delete_workingtime(workingtime) do
      send_resp(conn, :no_content, "")
    end
  end
end
