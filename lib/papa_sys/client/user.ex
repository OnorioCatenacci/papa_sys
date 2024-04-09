defmodule PapaSys.Client.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :role, :string
    field :first_name, :string
    field :last_name, :string
    field :email_address, :string
    field :account_minutes, :integer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:first_name, :last_name, :email_address, :role, :account_minutes])
    |> validate_required([:first_name, :last_name, :email_address, :role, :account_minutes])
    |> validate_number(:account_minutes, greater_than_or_equal_to: 0)
    |> validate_inclusion(:role,["member","pal","both"],message: "Role must be member, pal or both")
  end
end
