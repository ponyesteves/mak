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
    |> put_code
    |> validate_required([:code, :name, :desc])
    |> unique_constraint(:code)

  end

  def put_code(changeset) do
    unless(get_field(changeset, :code)) do
      change(changeset, %{code: gen_code() })
    else
      changeset
    end
  end

  defp gen_code do
    Ecto.UUID.generate |> binary_part(6,6)
  end
end
