defmodule Mak.Base.Machine do
  use Ecto.Schema
  import Ecto.Changeset


  schema "machines" do
    field :code, :string
    field :desc, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(machine, attrs) do
    machine
    |> cast(attrs, [:code, :name, :desc])
    |> validate_required([:code, :name, :desc])
  end
end
