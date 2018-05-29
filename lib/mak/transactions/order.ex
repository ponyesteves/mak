defmodule Mak.Transactions.Order do
  use Ecto.Schema
  import Ecto.Changeset

  schema "orders" do
    field(:date, :date, default: Mak.Helpers.today())
    field(:desc, :string)
    field(:title, :string)

    belongs_to(:type, Mak.Transactions.Code)
    belongs_to(:status, Mak.Transactions.Code)
    belongs_to(:machine, Mak.Base.Machine, type: :string)
    belongs_to(:user, Mak.Accounts.User)

    timestamps()
  end

  @doc false
  def changeset(order, attrs) do
    order
    |> cast(attrs, [:date, :title, :desc, :type_id, :status_id, :machine_id, :user_id])
    |> validate_required([:date, :title, :desc])
  end
end
