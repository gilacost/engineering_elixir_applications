defmodule KanbanWeb.PageControllerTest do
  use KanbanWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, ~p"/")
    assert html_response(conn, 200) =~ "Peace of mind from proto..."
  end
end