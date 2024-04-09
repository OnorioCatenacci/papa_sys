defmodule PapaSysWeb.UserJSON do
  alias PapaSys.Client.User

  @doc """
  Renders a list of users.
  """
  def index(%{users: users}) do
    %{data: for(user <- users, do: data(user))}
  end

  @doc """
  Renders a single user.
  """
  def show(%{user: user}) do
    %{data: data(user)}
  end

  defp data(%User{} = user) do
    %{
      id: user.id,
      role: user.role,
      first_name: user.first_name,
      last_name: user.last_name,
      email_address: user.email_address,
      account_minutes: user.account_minutes
    }
  end
end
