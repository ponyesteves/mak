defmodule Mak.Transactions.Order do
  use Ecto.Schema
  import Ecto.Changeset

  schema "orders" do
    field(:date, :date)
    field(:desc, :string)
    field(:title, :string)

    belongs_to(:status, Mak.Transactions.Code)
    belongs_to(:machine, Mak.Base.Machine, type: :string)
    belongs_to(:user, Mak.Accounts.User)

    timestamps()
  end

  @doc false
  def changeset(order, attrs) do
    order
    |> cast(attrs, [:date, :title, :desc, :status_id, :machine_id, :user_id])
    |> default_date
    |> validate_required([:date, :title, :desc])
  end

  def default_date(changeset) do
    case get_field(changeset, :date) do
      nil -> put_change(changeset, :date, Mak.Helpers.today)
      _ -> changeset
    end
  end
end
