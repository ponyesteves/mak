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
    |> cast(attrs, [:code, :name])
    |> validate_required([:code, :name])
  end
end
