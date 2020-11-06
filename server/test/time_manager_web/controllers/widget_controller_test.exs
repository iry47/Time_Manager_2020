defmodule TimeManagerWeb.WidgetControllerTest do
  use TimeManagerWeb.ConnCase

  alias TimeManager.Accounts
  alias TimeManager.Accounts.Widget

  @create_attrs %{
    description: "some description",
    name: "some name"
  }
  @update_attrs %{
    description: "some updated description",
    name: "some updated name"
  }
  @invalid_attrs %{description: nil, name: nil}

  setup do
    conn = conn() |> put_req_header("accept", "application/json") |> put_req_header("authorization", "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhY3RpdmVfaGFzaCI6ImZjN2U2ODNjYzBlOTFiNDcyY2IxZGY3YTUxYjM4MmFkIiwiYWRtaW4iOnRydWUsImVtYWlsIjoidGhlQG1haWwuY29tIiwiZmlyc3RuYW1lIjoiSHVnbyIsImdyaWRzdGVyIjpmYWxzZSwiaWQiOjUsImxhc3RuYW1lIjoiU2lsdmEiLCJtYW5hZ2VyIjpmYWxzZSwic2FsdCI6InMwbVJJZGxLdkkifQ.JiNSqgC0E3XXusxViD7_DYQKFi5oEqHwGU7pceeWviw")
    {:ok, conn: conn}
  end

  def fixture(:widget) do
    {:ok, widget} = Accounts.create_widget(@create_attrs)
    widget
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all widgets", %{conn: conn} do
      conn = get(conn, Routes.widget_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  # describe "create widget" do
  #   test "renders widget when data is valid", %{conn: conn} do
  #     conn = post(conn, Routes.widget_path(conn, :create), widget: @create_attrs)
  #     assert %{"id" => id} = json_response(conn, 201)["data"]

  #     conn = get(conn, Routes.widget_path(conn, :show, id))

  #     assert %{
  #              "id" => id,
  #              "description" => "some description",
  #              "name" => "some name"
  #            } = json_response(conn, 200)["data"]
  #   end

  #   test "renders errors when data is invalid", %{conn: conn} do
  #     conn = post(conn, Routes.widget_path(conn, :create), widget: @invalid_attrs)
  #     assert json_response(conn, 422)["errors"] != %{}
  #   end
  # end

  # describe "update widget" do
  #   setup [:create_widget]

  #   test "renders widget when data is valid", %{conn: conn, widget: %Widget{id: id} = widget} do
  #     conn = put(conn, Routes.widget_path(conn, :update, widget), widget: @update_attrs)
  #     assert %{"id" => ^id} = json_response(conn, 200)["data"]

  #     conn = get(conn, Routes.widget_path(conn, :show, id))

  #     assert %{
  #              "id" => id,
  #              "description" => "some updated description",
  #              "name" => "some updated name"
  #            } = json_response(conn, 200)["data"]
  #   end

  #   test "renders errors when data is invalid", %{conn: conn, widget: widget} do
  #     conn = put(conn, Routes.widget_path(conn, :update, widget), widget: @invalid_attrs)
  #     assert json_response(conn, 422)["errors"] != %{}
  #   end
  # end

  # describe "delete widget" do
  #   setup [:create_widget]

  #   test "deletes chosen widget", %{conn: conn, widget: widget} do
  #     conn = delete(conn, Routes.widget_path(conn, :delete, widget))
  #     assert response(conn, 204)

  #     assert_error_sent 404, fn ->
  #       get(conn, Routes.widget_path(conn, :show, widget))
  #     end
  #   end
  # end

  defp create_widget(_) do
    widget = fixture(:widget)
    {:ok, widget: widget}
  end
end
