defmodule PapaSys.ServiceFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PapaSys.Service` context.
  """

  @doc """
  Generate a visit.
  """
  def visit_fixture(user, attrs \\ %{}) do
    tomorrow = Date.add(Date.utc_today(), 1)

    {:ok, visit} =
      attrs
      |> Enum.into(%{
        user_id: user.id,
        visit_date: tomorrow,
        visit_duration: 60
      })
      |> PapaSys.Service.create_visit()

    visit
  end

  @doc """
  Generate a transaction.
  """
  def transaction_fixture(user, visit, attrs \\ %{}) do
    {:ok, transaction} =
      attrs
      |> Enum.into(%{
        member_id: user.id,
        pal_id: user.id,
        visit_id: visit.id
      })
      |> PapaSys.Service.create_transaction()

    transaction
  end
end
