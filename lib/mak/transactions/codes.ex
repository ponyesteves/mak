defmodule Mak.Transactions.Code do
  use Ecto.Schema
  import Ecto.Changeset

  schema "codes" do
    field :name, :string
    field :scope, :string
    timestamps()
  end

  @doc false
  def changeset(type, attrs) do
    type
    |> cast(attrs, [:scope, :name])
    |> validate_required([:scope, :name])
  end
end
