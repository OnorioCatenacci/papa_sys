defmodule PapaSys.Service.Transaction do
  use Ecto.Schema
  import Ecto.Changeset

  schema "transactions" do
    belongs_to :member, PapaSys.Client.User, foreign_key: :member_id
    belongs_to :pal, PapaSys.Client.User, foreign_key: :pal_id
    belongs_to :visit, PapaSys.Service.Visit, foreign_key: :visit_id

    timestamps(type: :utc_datetime)
  end

  @required_fields ~w(member_id pal_id visit_id)a

  @doc false
  def changeset(transaction, attrs) do
    transaction
    |> cast(attrs, [:member_id, :pal_id, :visit_id])
    |> validate_required(@required_fields)
    |> foreign_key_constraint(:member_id_fk, message: "Member not found in users list")
    |> foreign_key_constraint(:pal_id_fk, message: "Pal not found in users list")
    |> foreign_key_constraint(:visit_id_fk, message: "Visit not found in visits list")
  end
end
