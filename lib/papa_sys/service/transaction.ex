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
    |> validate_time_is_available(:member_id)
  end

  def validate_time_is_available(changeset, field) do
    validate_change(changeset, field, fn _field, _value ->
      with {:ok, time_available_for_visits} <- PapaSys.Client.time_available(get_field(changeset, :member_id)),
           {:ok, requested_visit_duration} <-
             PapaSys.Service.requested_duration_of_visit(get_field(changeset,:visit_id)) do
        # The person requesting the visit must have at least 
        required_time = ceil(requested_visit_duration * 1.15)
        # 15% more time available than the requested visit duration
        if time_available_for_visits >= required_time do
          []
        else
          [{field, "Not enough time available for the visit"}]
        end
      else
        _ -> [{field, "Not enough time available for the visit"}]
      end
    end)
  end
end
