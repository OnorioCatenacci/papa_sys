defmodule PapaSys.ServiceTest do
  use PapaSys.DataCase

  alias PapaSys.Service

  describe "visits" do
    alias PapaSys.Service.Visit

    import PapaSys.ServiceFixtures

    @invalid_attrs %{visit_date: Date.add(DateTime.utc_now(),-2), visit_duration: -1}

    # On all test cases we need to have a user created before the visit and/or the transaction can get inserted due to 
    # the foreign key constraints.

    test "list_visits/0 returns all visits" do
      _user = PapaSys.ClientFixtures.user_fixture()
      visit = visit_fixture()
      assert Service.list_visits() == [visit]
    end

    test "get_visit!/1 returns the visit with given id" do
      _user = PapaSys.ClientFixtures.user_fixture()
      visit = visit_fixture()
      assert Service.get_visit!(visit.id) == visit
    end

    test "create_visit/1 with valid data creates a visit" do
      user = PapaSys.ClientFixtures.user_fixture()
      valid_attrs = %{user_id: user.id, visit_date: DateTime.utc_now(), visit_duration: 60}

      assert {:ok, %Visit{} = _visit} = Service.create_visit(valid_attrs)
    end

    test "create_visit/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Service.create_visit(@invalid_attrs)
    end

    test "update_visit/2 with valid data updates the visit" do
      user = PapaSys.ClientFixtures.user_fixture()
      visit = visit_fixture()
      update_attrs = %{user_id: user.id, visit_date: DateTime.utc_now(), visit_duration: 120}

      assert {:ok, %Visit{} = _visit} = Service.update_visit(visit, update_attrs)
    end

    test "update_visit/2 with invalid data returns error changeset" do
      _user = PapaSys.ClientFixtures.user_fixture()
      visit = visit_fixture()
      assert {:error, %Ecto.Changeset{}} = Service.update_visit(visit, @invalid_attrs)
      assert visit == Service.get_visit!(visit.id)
    end

    test "delete_visit/1 deletes the visit" do
      _user = PapaSys.ClientFixtures.user_fixture()
      visit = visit_fixture()
      assert {:ok, %Visit{}} = Service.delete_visit(visit)
      assert_raise Ecto.NoResultsError, fn -> Service.get_visit!(visit.id) end
    end

    test "change_visit/1 returns a visit changeset" do
      _user = PapaSys.ClientFixtures.user_fixture()
      visit = visit_fixture()
      assert %Ecto.Changeset{} = Service.change_visit(visit)
    end
  end

  describe "transactions" do
    alias PapaSys.Service.Transaction

    import PapaSys.ServiceFixtures

    @invalid_attrs %{member_id: 0}

    test "list_transactions/0 returns all transactions" do
      _user = PapaSys.ClientFixtures.user_fixture()
      _visit = visit_fixture()
      transaction = transaction_fixture()
      assert Service.list_transactions() == [transaction]
    end

    test "get_transaction!/1 returns the transaction with given id" do
      _user = PapaSys.ClientFixtures.user_fixture()
      _visit = visit_fixture()
      transaction = transaction_fixture()
      assert Service.get_transaction!(transaction.id) == transaction
    end

    test "create_transaction/1 with valid data creates a transaction" do
      user = PapaSys.ClientFixtures.user_fixture()
      visit = visit_fixture()
      valid_attrs = %{member_id: user.id, visit_id: visit.id, pal_id: user.id}

      assert {:ok, %Transaction{} = _transaction} = Service.create_transaction(valid_attrs)
    end

    test "create_transaction/1 with invalid data returns error changeset" do
      _user = PapaSys.ClientFixtures.user_fixture()
      _visit = visit_fixture()
      assert {:error, %Ecto.Changeset{}} = Service.create_transaction(@invalid_attrs)
    end

    test "update_transaction/2 with valid data updates the transaction" do
      _user = PapaSys.ClientFixtures.user_fixture()
      _visit = visit_fixture()
      transaction = transaction_fixture()
      update_attrs = %{}

      assert {:ok, %Transaction{} = _transaction} = Service.update_transaction(transaction, update_attrs)
    end

    test "update_transaction/2 with invalid data returns error changeset" do
      _user = PapaSys.ClientFixtures.user_fixture()
      _visit = visit_fixture()
      transaction = transaction_fixture()
      assert {:error, %Ecto.Changeset{}} = Service.update_transaction(transaction, @invalid_attrs)
      assert transaction == Service.get_transaction!(transaction.id)
    end

    test "delete_transaction/1 deletes the transaction" do
      _user = PapaSys.ClientFixtures.user_fixture()
      _visit = visit_fixture()
      transaction = transaction_fixture()
      assert {:ok, %Transaction{}} = Service.delete_transaction(transaction)
      assert_raise Ecto.NoResultsError, fn -> Service.get_transaction!(transaction.id) end
    end

    test "change_transaction/1 returns a transaction changeset" do
      _user = PapaSys.ClientFixtures.user_fixture()
      _visit = visit_fixture()
      transaction = transaction_fixture()
      assert %Ecto.Changeset{} = Service.change_transaction(transaction)
    end
  end
end
