defmodule PapaSys.Client do
  @moduledoc """
  The Client context.
  """

  import Ecto.Query, warn: false
  alias PapaSys.Repo

  alias PapaSys.Client.User

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{data: %User{}}

  """
  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end

  @doc """
  Returns a tuple containing either 
  {:ok, time_available} for a valid user or 
  {:error, :invalid_user} for an invalid user.
  """
  @spec time_available(integer) :: {:ok, integer} | {:error, :invalid_user}
  def time_available(user_id) do
    if not user_exists?(user_id) do
      alias PapaSys.Repo
      {:error, :invalid_user}
    else
      user = get_user!(user_id)
      {:ok, user.account_minutes}
    end
  end

  @doc """
  We want to determine if the user is a pal.  Pals can fulfill a visit request and members can request a visit.

  Note: the user_exists? function is a call to the DB and the get_user! is also a call.  If this were production code, using two calls where one would work, is poor performance.  However, since this is demonstration code for a coding challenge I'm not going to fix this.

  """
  @spec is_pal?(integer) :: boolean
  def is_pal?(user_id) do
    if not user_exists?(user_id) do
      false
    else
      user = get_user!(user_id)
      user.role == "pal" || user.role == "both"
    end
  end

  @doc """
  We want to determine if the user is a member.  Pals can fulfill a visit request and members can request a visit.
  """
  @spec is_member?(integer) :: boolean
  def is_member?(user_id) do
    if not user_exists?(user_id) do
      false
    else
      user = get_user!(user_id)
      user.role == "member" || user.role == "both"
    end
  end

  defp user_exists?(id) do
    Repo.get(User, id) != nil
  end
end
