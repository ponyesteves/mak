defmodule Mak.Base.Machine do
  use Ecto.Schema
  import Ecto.Changeset


  schema "machines" do
    field :code, :string
    field :desc, :string
    field :name, :string
    field :image, :binary

    timestamps()
  end

  @doc false
  def changeset(machine, attrs) do
    machine
    |> cast(attrs, [:code, :name, :desc])
    |> parse_image(attrs)
    |> put_code
    |> validate_required([:code, :name, :desc])
    |> unique_constraint(:code)
    |> IO.inspect

  end

  def parse_image(changeset, %{"image" => image} ) do
    file = File.read!(image.path)
    IO.inspect is_binary(file)
    IO.inspect File.read!(image.path)
    change(changeset, %{image: File.read!(image.path)})
  end

  def parse_image(changeset, _), do: changeset

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

  # For slugging
  # defimpl Phoenix.Param, for: Mak.Base.Machine do
  #   def to_param(%{code: code}), do: code
  # end
end
