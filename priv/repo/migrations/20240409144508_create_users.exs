defmodule PapaSys.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :first_name, :string
      add :last_name, :string
      add :email_address, :string
      add :role, :string
      add :account_minutes, :integer

      timestamps(type: :utc_datetime)
    end
  end
end
