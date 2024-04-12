defmodule PapaSys.ClientFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PapaSys.Client` context.
  """

  @doc """
  Generate a member user.
  """
  def member_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        account_minutes: 240,
        email_address: "some email_address",
        first_name: "some first_name",
        last_name: "some last_name",
        role: "member"
      })
      |> PapaSys.Client.create_user()

    user
  end

  @doc """
  Generate a pal user.
  """
  def pal_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        account_minutes: 240,
        email_address: "pal@pal.com",
        first_name: "Joe",
        last_name: "Doe",
        role: "pal"
      })
      |> PapaSys.Client.create_user()

    user
  end
end
