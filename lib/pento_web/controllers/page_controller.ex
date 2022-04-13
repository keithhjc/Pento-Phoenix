defmodule PentoWeb.PageController do
  use PentoWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def guess(conn, _params) do
    # Redirect to dashboard home
    redirect(conn, to: Routes.live_dashboard_path(conn, :home))
  end
end
