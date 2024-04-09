defmodule PapaSys.ClientFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PapaSys.Client` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        account_minutes: 42,
        email_address: "some email_address",
        first_name: "some first_name",
        last_name: "some last_name",
        role: "member"
      })
      |> PapaSys.Client.create_user()

    user
  end
end
