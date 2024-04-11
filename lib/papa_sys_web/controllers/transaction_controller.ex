defmodule PapaSysWeb.TransactionController do
  use PapaSysWeb, :controller

  alias PapaSys.Service
  alias PapaSys.Service.Transaction

  action_fallback PapaSysWeb.FallbackController

  def index(conn, _params) do
    transactions = Service.list_transactions()
    render(conn, :index, transactions: transactions)
  end

  def create(conn, %{"transaction" => transaction_params}) do
    with {:ok, %Transaction{} = transaction} <- Service.create_transaction(transaction_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/transactions/#{transaction}")
      |> render(:show, transaction: transaction)
    end
  end

  def show(conn, %{"id" => id}) do
    transaction = Service.get_transaction!(id)
    render(conn, :show, transaction: transaction)
  end

  def update(conn, %{"id" => id, "transaction" => transaction_params}) do
    transaction = Service.get_transaction!(id)

    with {:ok, %Transaction{} = transaction} <-
           Service.update_transaction(transaction, transaction_params) do
      render(conn, :show, transaction: transaction)
    end
  end

  def delete(conn, %{"id" => id}) do
    transaction = Service.get_transaction!(id)

    with {:ok, %Transaction{}} <- Service.delete_transaction(transaction) do
      send_resp(conn, :no_content, "")
    end
  end
end
