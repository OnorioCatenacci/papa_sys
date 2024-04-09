defmodule PapaSys.ClientTest do
  use PapaSys.DataCase

  alias PapaSys.Client

  describe "users" do
    alias PapaSys.Client.User

    import PapaSys.ClientFixtures

    @invalid_attrs %{role: nil, first_name: nil, last_name: nil, email_address: nil, account_minutes: nil}

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Client.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Client.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{role: "member", first_name: "some first_name", last_name: "some last_name", email_address: "some email_address", account_minutes: 42}

      assert {:ok, %User{} = user} = Client.create_user(valid_attrs)
      assert user.role == "member"
      assert user.first_name == "some first_name"
      assert user.last_name == "some last_name"
      assert user.email_address == "some email_address"
      assert user.account_minutes == 42
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Client.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      update_attrs = %{role: "member", first_name: "some updated first_name", last_name: "some updated last_name", email_address: "some updated email_address", account_minutes: 43}

      assert {:ok, %User{} = user} = Client.update_user(user, update_attrs)
      assert user.role == "member"
      assert user.first_name == "some updated first_name"
      assert user.last_name == "some updated last_name"
      assert user.email_address == "some updated email_address"
      assert user.account_minutes == 43
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Client.update_user(user, @invalid_attrs)
      assert user == Client.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Client.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Client.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Client.change_user(user)
    end
  end
end
