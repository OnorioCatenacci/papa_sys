defmodule PapaSys.Service.Visit do
  use Ecto.Schema
  import Ecto.Changeset

  schema "visits" do
    field :visit_date, :date
    field :visit_duration, :integer

    belongs_to :user, PapaSys.Client.User, foreign_key: :user_id
    timestamps(type: :utc_datetime)
  end

  @required_fields ~w(visit_date visit_duration)a
  @doc false
  def changeset(visit, attrs) do
    visit
    |> cast(attrs, [:visit_date, :visit_duration, :user_id])
    |> foreign_key_constraint(:user_id,
      name: :user_id_fkey,
      message: "User id specified does not exist"
    )
    |> validate_required(@required_fields)
    |> validate_number(:visit_duration, greater_than: 0)
    |> validate_visit_date(:visit_date)
    |> validate_pal_is_requesting_visit(:user_id)
  end

  defp validate_visit_date(changeset, field) do
    validate_change(changeset, field, fn _field, value ->
      cond do
        Date.compare(value, Date.utc_today()) == :eq ||
            Date.compare(value, Date.utc_today()) == :gt ->
          []

        true ->
          [{field, "cannot be in the past"}]
      end
    end)
  end

  defp validate_pal_is_requesting_visit(changeset, field) do
    validate_change(changeset, field, fn _field, _value ->
      if PapaSys.Client.is_pal?(get_field(changeset, :user_id)) do
        []
      else
        [{field, "A user who is not a pal cannot request a visit"}]
      end
    end)
  end
end
