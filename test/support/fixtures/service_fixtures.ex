defmodule PapaSys.ServiceFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PapaSys.Service` context.
  """

  @doc """
  Generate a visit.
  """
  def visit_fixture(member, attrs \\ %{}) do
    tomorrow = Date.add(Date.utc_today(), 1)

    {:ok, visit} =
      attrs
      |> Enum.into(%{
        user_id: member.id,
        visit_date: tomorrow,
        visit_duration: 60
      })
      |> PapaSys.Service.create_visit()

    visit
  end

  @doc """
  Generate a transaction.
  """
  def transaction_fixture(member, pal, visit, attrs \\ %{}) do
    {:ok, transaction} =
      attrs
      |> Enum.into(%{
        member_id: member.id,
        pal_id: pal.id,
        visit_id: visit.id
      })
      |> PapaSys.Service.create_transaction()

    transaction
  end
end
