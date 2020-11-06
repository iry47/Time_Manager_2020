defmodule TimeManagerWeb.TeamUserControllerTest do
  use TimeManagerWeb.ConnCase

  alias TimeManager.Accounts
  alias TimeManager.Accounts.TeamUser

  @create_attrs %{
      user: 1,
      team: 1
  }
  @update_attrs %{
      user: 1,
      team: 2
  }
  @invalid_attrs %{user: nil, team: nil}

  setup do
    conn = conn() |> put_req_header("accept", "application/json") |> put_req_header("authorization", "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhY3RpdmVfaGFzaCI6ImZjN2U2ODNjYzBlOTFiNDcyY2IxZGY3YTUxYjM4MmFkIiwiYWRtaW4iOnRydWUsImVtYWlsIjoidGhlQG1haWwuY29tIiwiZmlyc3RuYW1lIjoiSHVnbyIsImdyaWRzdGVyIjpmYWxzZSwiaWQiOjUsImxhc3RuYW1lIjoiU2lsdmEiLCJtYW5hZ2VyIjpmYWxzZSwic2FsdCI6InMwbVJJZGxLdkkifQ.JiNSqgC0E3XXusxViD7_DYQKFi5oEqHwGU7pceeWviw")
    {:ok, conn: conn}
  end

  def fixture(:team_user) do
    {:ok, team_user} = Accounts.create_team_user(@create_attrs)
    team_user
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all teamusers", %{conn: conn} do
      conn = get(conn, Routes.team_user_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create team_user" do
    test "renders team_user when data is valid", %{conn: conn} do
      conn = post(conn, Routes.team_user_path(conn, :create), team_user: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.team_user_path(conn, :show, id))

      assert %{
               "id" => id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.team_user_path(conn, :create), team_user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update team_user" do
    setup [:create_team_user]

    test "renders team_user when data is valid", %{conn: conn, team_user: %TeamUser{id: id} = team_user} do
      conn = put(conn, Routes.team_user_path(conn, :update, team_user), team_user: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.team_user_path(conn, :show, id))

      assert %{
               "id" => id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, team_user: team_user} do
      conn = put(conn, Routes.team_user_path(conn, :update, team_user), team_user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete team_user" do
    setup [:create_team_user]

    test "deletes chosen team_user", %{conn: conn, team_user: team_user} do
      conn = delete(conn, Routes.team_user_path(conn, :delete, team_user))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.team_user_path(conn, :show, team_user))
      end
    end
  end

  defp create_team_user(_) do
    team_user = fixture(:team_user)
    {:ok, team_user: team_user}
  end
end
