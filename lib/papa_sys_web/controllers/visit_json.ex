defmodule PapaSysWeb.VisitJSON do
  alias PapaSys.Service.Visit

  @doc """
  Renders a list of visits.
  """
  def index(%{visits: visits}) do
    %{data: for(visit <- visits, do: data(visit))}
  end

  @doc """
  Renders a single visit.
  """
  def show(%{visit: visit}) do
    %{data: data(visit)}
  end

  defp data(%Visit{} = visit) do
    %{
      id: visit.id,
      visit_date: visit.visit_date,
      visit_duration: visit.visit_duration
    }
  end
end
