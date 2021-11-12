defmodule ApiWeb.PageControllerTest do
  use ApiWeb.ConnCase

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end
  test "GET /api", %{conn: conn} do
    conn = get(conn, "/api")
    assert response(conn, 200)
  end
end
