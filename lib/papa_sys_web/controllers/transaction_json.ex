defmodule PapaSysWeb.TransactionJSON do
  alias PapaSys.Service.Transaction

  @doc """
  Renders a list of transactions.
  """
  def index(%{transactions: transactions}) do
    %{data: for(transaction <- transactions, do: data(transaction))}
  end

  @doc """
  Renders a single transaction.
  """
  def show(%{transaction: transaction}) do
    %{data: data(transaction)}
  end

  defp data(%Transaction{} = transaction) do
    %{
      id: transaction.id,
      member_id: transaction.member_id,
      pal_id: transaction.pal_id,
      visit_id: transaction.visit_id
    }
  end
end
