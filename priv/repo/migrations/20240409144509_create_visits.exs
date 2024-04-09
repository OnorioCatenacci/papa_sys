defmodule PapaSys.Repo.Migrations.CreateVisits do
  use Ecto.Migration

  def change do
    create table(:visits) do
      add :visit_date, :date
      add :visit_duration, :integer
      add :user_id, references(:users, on_delete: :nilify_all)
      timestamps(type: :utc_datetime)
    end
  end
end
