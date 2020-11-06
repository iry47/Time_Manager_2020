defmodule TimeManagerWeb.WidgetUserControllerTest do
  use TimeManagerWeb.ConnCase

  alias TimeManager.Accounts
  alias TimeManager.Accounts.WidgetUser
  alias TimeManager.Accounts.Widget

  @create_attrs %{
    param_one: "some param_one",
    param_two: "some param_two",
    value_one: 120.5,
    value_two: 120.5,
    x: 42,
    y: 42,
    widget: 1,
    user: 1
  }
  @update_attrs %{
    param_one: "some updated param_one",
    param_two: "some updated param_two",
    value_one: 456.7,
    value_two: 456.7,
    x: 43,
    y: 43,
    widget: 1,
    user: 1
  }
  @invalid_attrs %{param_one: nil, param_two: nil, value_one: nil, value_two: nil, x: nil, y: nil, widget: nil, user: nil}

  

  setup do
    conn = conn() |> put_req_header("accept", "application/json") |> put_req_header("authorization", "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhY3RpdmVfaGFzaCI6ImZjN2U2ODNjYzBlOTFiNDcyY2IxZGY3YTUxYjM4MmFkIiwiYWRtaW4iOnRydWUsImVtYWlsIjoidGhlQG1haWwuY29tIiwiZmlyc3RuYW1lIjoiSHVnbyIsImdyaWRzdGVyIjpmYWxzZSwiaWQiOjUsImxhc3RuYW1lIjoiU2lsdmEiLCJtYW5hZ2VyIjpmYWxzZSwic2FsdCI6InMwbVJJZGxLdkkifQ.JiNSqgC0E3XXusxViD7_DYQKFi5oEqHwGU7pceeWviw")
    {:ok, conn: conn}
  end

  def fixture(:widget_user) do
    {:ok, widget_user} = Accounts.create_widget_user(@create_attrs)
    widget_user
  end

  def fixture_widget(:widget) do
    {:ok, widget} = Accounts.create_widget(%{name: "w1", description: "thedesc"})
    widget
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all widgetusers", %{conn: conn} do
      conn = get(conn, Routes.widget_user_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  # describe "create widget_user" do
  #   test "renders widget_user when data is valid", %{conn: conn} do
  #     conn = post(conn, Routes.widget_user_path(conn, :create, user: @create_attrs.user, widget: @create_attrs.widget), widget_user: @create_attrs)
  #     assert %{"id" => id} = json_response(conn, 201)["data"]

  #     conn = get(conn, Routes.widget_user_path(conn, :show, id))

  #     assert %{
  #              "id" => id,
  #              "param_one" => "some param_one",
  #              "param_two" => "some param_two",
  #              "value_one" => 120.5,
  #              "value_two" => 120.5,
  #              "x" => 42,
  #              "y" => 42
  #            } = json_response(conn, 200)["data"]
  #   end

  #   test "renders errors when data is invalid", %{conn: conn} do
  #     conn = post(conn, Routes.widget_user_path(conn, :create, user: @create_attrs.user, widget: @create_attrs.widget), widget_user: @invalid_attrs)
  #     assert json_response(conn, 422)["errors"] != %{}
  #   end
  # end

  # describe "update widget_user" do
  #   setup [:create_widget_user]

  #   test "renders widget_user when data is valid", %{conn: conn, widget_user: %WidgetUser{id: id} = widget_user, widget: %Widget{id: id} = widget} do
  #     conn = put(conn, Routes.widget_user_path(conn, :update, user: widget_user.user, widget: widget.id), widget_user: @update_attrs)
  #     assert %{"id" => ^id} = json_response(conn, 200)["data"]

  #     conn = get(conn, Routes.widget_user_path(conn, :show, id))

  #     assert %{
  #              "id" => id,
  #              "param_one" => "some updated param_one",
  #              "param_two" => "some updated param_two",
  #              "value_one" => 456.7,
  #              "value_two" => 456.7,
  #              "x" => 43,
  #              "y" => 43
  #            } = json_response(conn, 200)["data"]
  #   end

  #   test "renders errors when data is invalid", %{conn: conn, widget_user: widget_user} do
  #     conn = put(conn, Routes.widget_user_path(conn, :update, widget_user), widget_user: @invalid_attrs)
  #     assert json_response(conn, 422)["errors"] != %{}
  #   end
  # end

  # describe "delete widget_user" do
  #   setup [:create_widget_user]

  #   test "deletes chosen widget_user", %{conn: conn, widget_user: widget_user} do
  #     conn = delete(conn, Routes.widget_user_path(conn, :delete, widget_user))
  #     assert response(conn, 204)

  #     assert_error_sent 404, fn ->
  #       get(conn, Routes.widget_user_path(conn, :show, widget_user))
  #     end
  #   end
  # end

  # defp create_widget_user(_) do
  #   widget_user = fixture(:widget_user)
  #   widget = fixture_widget(:widget)
  #   {:ok, widget_user: widget_user, widget: widget}
  # end
end
