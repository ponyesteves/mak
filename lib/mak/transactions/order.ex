defmodule Mak.Transactions.Order do
  use Ecto.Schema
  import Ecto.Changeset


  schema "orders" do
    field :date, :date
    field :desc, :string
    field :title, :string
    field :type_id, :id
    field :machine_id, :id
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(order, attrs) do
    order
    |> cast(attrs, [:date, :title, :desc])
    |> validate_required([:date, :title, :desc])
  end
end
