defmodule Mak.Transactions.Type do
  use Ecto.Schema
  import Ecto.Changeset


  schema "types" do
    field :code, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(type, attrs) do
    type
    |> cast(attrs, [:code, :name])
    |> validate_required([:code, :name])
  end
end
