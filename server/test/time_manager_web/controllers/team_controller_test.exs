defmodule TimeManagerWeb.TeamControllerTest do
  use TimeManagerWeb.ConnCase

  alias TimeManager.Accounts
  alias TimeManager.Accounts.Team

  @create_attrs %{
    name: "some name"
  }
  @update_attrs %{
    name: "some updated name"
  }
  @invalid_attrs %{name: nil}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhY3RpdmVfaGFzaCI6ImZjN2U2ODNjYzBlOTFiNDcyY2IxZGY3YTUxYjM4MmFkIiwiYWRtaW4iOnRydWUsImVtYWlsIjoidGhlQG1haWwuY29tIiwiZmlyc3RuYW1lIjoiSHVnbyIsImdyaWRzdGVyIjpmYWxzZSwiaWQiOjUsImxhc3RuYW1lIjoiU2lsdmEiLCJtYW5hZ2VyIjpmYWxzZSwic2FsdCI6InMwbVJJZGxLdkkifQ.JiNSqgC0E3XXusxViD7_DYQKFi5oEqHwGU7pceeWviw"
    {:ok, conn: conn, token: token}
  end

  def fixture(:team) do
    {:ok, team} = Accounts.create_team(@create_attrs)
    team
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    # test "lists all teams", %{conn: conn} do
    #   conn = get(conn, Routes.team_path(conn, :index))
    #   assert json_response(conn, 200) == []
    # end
  end

  # describe "create team" do
  #   test "renders team when data is valid", %{conn: conn} do
  #     conn = post(conn, Routes.team_path(conn, :create), team: @create_attrs)
  #     assert %{"id" => id} = json_response(conn, 201)["data"]

  #     conn = get(conn, Routes.team_path(conn, :show, id))

  #     assert %{
  #              "id" => id,
  #              "name" => "some name"
  #            } = json_response(conn, 200)["data"]
  #   end

  #   test "renders errors when data is invalid", %{conn: conn} do
  #     conn = post(conn, Routes.team_path(conn, :create), team: @invalid_attrs)
  #     assert json_response(conn, 422)["errors"] != %{}
  #   end
  # end

  # describe "update team" do
  #   setup [:create_team]

  #   test "renders team when data is valid", %{conn: conn, team: %Team{id: id} = team} do
  #     conn = put(conn, Routes.team_path(conn, :update, team), team: @update_attrs)
  #     assert %{"id" => ^id} = json_response(conn, 200)["data"]

  #     conn = get(conn, Routes.team_path(conn, :show, id))

  #     assert %{
  #              "id" => id,
  #              "name" => "some updated name"
  #            } = json_response(conn, 200)["data"]
  #   end

  #   test "renders errors when data is invalid", %{conn: conn, team: team} do
  #     conn = put(conn, Routes.team_path(conn, :update, team), team: @invalid_attrs)
  #     assert json_response(conn, 422)["errors"] != %{}
  #   end
  # end

  # describe "delete team" do
  #   setup [:create_team]

  #   test "deletes chosen team", %{conn: conn, team: team} do
  #     conn = delete(conn, Routes.team_path(conn, :delete, team))
  #     assert response(conn, 204)

  #     assert_error_sent 404, fn ->
  #       get(conn, Routes.team_path(conn, :show, team))
  #     end
  #   end
  # end

  defp create_team(_) do
    team = fixture(:team)
    {:ok, team: team}
  end
end
