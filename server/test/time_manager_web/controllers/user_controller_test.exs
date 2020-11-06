defmodule TimeManagerWeb.UserControllerTest do
  use TimeManagerWeb.ConnCase

  alias TimeManager.Accounts
  alias TimeManager.Accounts.User

  @create_attrs %{
    admin: true,
    email: "email@me.com",
    gridster: true,
    active_hash: "some hash",
    manager: true,
    lastname: "some lastname",
    salt: "some salt",
    firstname: "some firstname"
  }
  @update_attrs %{
    admin: false,
    email: "email@me.com",
    gridster: false,
    active_hash: "some updated hash",
    manager: false,
    lastname: "some updated lastname",
    salt: "some updated salt",
    firstname: "some updated firstname"
  }
  @invalid_attrs %{admin: nil, email: nil, gridster: nil, active_hash: nil, manager: nil, lastname: nil, salt: nil, firstname: nil}

  setup do
    conn = conn() |> put_req_header("accept", "application/json") |> put_req_header("authorization", "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhY3RpdmVfaGFzaCI6ImZjN2U2ODNjYzBlOTFiNDcyY2IxZGY3YTUxYjM4MmFkIiwiYWRtaW4iOnRydWUsImVtYWlsIjoidGhlQG1haWwuY29tIiwiZmlyc3RuYW1lIjoiSHVnbyIsImdyaWRzdGVyIjpmYWxzZSwiaWQiOjUsImxhc3RuYW1lIjoiU2lsdmEiLCJtYW5hZ2VyIjpmYWxzZSwic2FsdCI6InMwbVJJZGxLdkkifQ.JiNSqgC0E3XXusxViD7_DYQKFi5oEqHwGU7pceeWviw")
    {:ok, conn: conn}
  end

  def fixture(:user) do
    {:ok, user} = Accounts.create_user(@create_attrs)
    user
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all users", %{conn: conn} do
      conn = get(conn, Routes.user_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create user" do
    # test "renders user when data is valid", %{conn: conn} do
    #   conn = post(conn, Routes.user_path(conn, :create), user: @create_attrs)
    #   assert %{"id" => id} = json_response(conn, 201)["data"]

    #   conn = get(conn, Routes.user_path(conn, :show, id))

    #   assert %{
    #            "id" => id,
    #            "admin" => true,
    #            "email" => "email@me.com",
    #            "gridster" => true,
    #            "active_hash" => "some hash",
    #            "manager" => true,
    #            "lastname" => "some lastname",
    #            "salt" => "some salt",
    #            "firstname" => "some firstname"
    #          } = json_response(conn, 200)["data"]
    # end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update user" do
    setup [:create_user]

    # test "renders user when data is valid", %{conn: conn, user: %User{id: id} = user} do
    #   conn = put(conn, Routes.user_path(conn, :update, user), user: @update_attrs)
    #   assert %{"id" => ^id} = json_response(conn, 200)["data"]

    #   conn = get(conn, Routes.user_path(conn, :show, id))

    #   assert %{
    #            "id" => id,
    #            "admin" => false,
    #            "email" => "email@me.com",
    #            "gridster" => false,
    #            "active_hash" => "some updated hash",
    #            "manager" => false,
    #            "lastname" => "some updated lastname",
    #            "salt" => "some updated salt",
    #            "firstname" => "some updated firstname"
    #          } = json_response(conn, 200)["data"]
    # end

    # test "renders errors when data is invalid", %{conn: conn, user: user} do
    #   conn = put(conn, Routes.user_path(conn, :update, user), user: @invalid_attrs)
    #   assert json_response(conn, 422)["errors"] != %{}
    # end
  end

  describe "delete user" do
    setup [:create_user]

    test "deletes chosen user", %{conn: conn, user: user} do
      conn = delete(conn, Routes.user_path(conn, :delete, user))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.user_path(conn, :show, user))
      end
    end
  end

  defp create_user(_) do
    user = fixture(:user)
    {:ok, user: user}
  end
end
