# in lib/kanban_web/controllers/page_controller.ex

defmodule KanbanWeb.PageController do
  use KanbanWeb, :controller

  @spec home(Plug.Conn.t(), map()) :: []
  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false)
  end
end
