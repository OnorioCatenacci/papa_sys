defmodule PapaSys.Repo.Migrations.CreateTransactions do
  use Ecto.Migration

  def change do
    create table(:transactions) do
      add :member_id, references(:users, on_delete: :nilify_all)
      add :pal_id, references(:users, on_delete: :nilify_all)
      add :visit_id, references(:visits, on_delete: :nilify_all)
      timestamps(type: :utc_datetime)
    end
  end
end
