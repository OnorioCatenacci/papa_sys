defmodule PapaSysWeb.TransactionControllerTest do
  use PapaSysWeb.ConnCase

  import PapaSys.ServiceFixtures

  alias PapaSys.Service.Transaction

  @create_attrs %{
    member_id: 1,
    pal_id: 2,
    visit_id: 1
  }
  @update_attrs %{
    member_id: 1,
    pal_id: 2,
    visit_id: 2
  }
  @invalid_attrs %{member_id: nil, pal_id: nil, visit_id: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all transactions", %{conn: conn} do
      conn = get(conn, ~p"/api/transactions")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create transaction" do
    test "renders transaction when data is valid", %{conn: conn} do
      member = PapaSys.ClientFixtures.member_fixture()
      _visit = visit_fixture(member)
      _pal = PapaSys.ClientFixtures.pal_fixture()

      conn = post(conn, ~p"/api/transactions", transaction: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/transactions/#{id}")

      assert %{
               "id" => ^id,
               "member_id" => 1,
               "pal_id" => 2,
               "visit_id" => 1
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/transactions", transaction: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update transaction" do
    setup [:create_transaction]

    test "renders transaction when data is valid", %{
      conn: conn,
      transaction: %Transaction{id: id} = transaction
    } do
      user = PapaSys.ClientFixtures.member_fixture()
      _visit = visit_fixture(user)
      conn = put(conn, ~p"/api/transactions/#{transaction}", transaction: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/transactions/#{id}")

      assert %{
               "id" => ^id,
               "member_id" => 1,
               "pal_id" => 2,
               "visit_id" => 2
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, transaction: transaction} do
      conn = put(conn, ~p"/api/transactions/#{transaction}", transaction: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete transaction" do
    setup [:create_transaction]

    test "deletes chosen transaction", %{conn: conn, transaction: transaction} do
      conn = delete(conn, ~p"/api/transactions/#{transaction}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/transactions/#{transaction}")
      end
    end
  end

  defp create_transaction(_) do
    member = PapaSys.ClientFixtures.member_fixture()
    pal = PapaSys.ClientFixtures.pal_fixture()
    visit = visit_fixture(member)
    transaction = transaction_fixture(member, pal, visit)
    %{transaction: transaction}
  end
end
