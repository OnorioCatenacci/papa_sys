defmodule PapaSysWeb.VisitController do
  use PapaSysWeb, :controller

  alias PapaSys.Service
  alias PapaSys.Service.Visit

  action_fallback PapaSysWeb.FallbackController

  def index(conn, _params) do
    visits = Service.list_visits()
    render(conn, :index, visits: visits)
  end

  def create(conn, %{"visit" => visit_params}) do
    with {:ok, %Visit{} = visit} <- Service.create_visit(visit_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/visits/#{visit}")
      |> render(:show, visit: visit)
    end
  end

  def show(conn, %{"id" => id}) do
    visit = Service.get_visit!(id)
    render(conn, :show, visit: visit)
  end

  def update(conn, %{"id" => id, "visit" => visit_params}) do
    visit = Service.get_visit!(id)

    with {:ok, %Visit{} = visit} <- Service.update_visit(visit, visit_params) do
      render(conn, :show, visit: visit)
    end
  end

  def delete(conn, %{"id" => id}) do
    visit = Service.get_visit!(id)

    with {:ok, %Visit{}} <- Service.delete_visit(visit) do
      send_resp(conn, :no_content, "")
    end
  end
end
