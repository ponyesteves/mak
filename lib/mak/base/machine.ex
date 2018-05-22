defmodule Mak.Base.Machine do
  use Ecto.Schema
  import Ecto.Changeset
  import MakWeb.Gettext, only: [dgettext: 3]

  schema "machines" do
    field(:code, :string)
    field(:desc, :string)
    field(:name, :string)
    field(:image, :binary)

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
  end

  def parse_image(changeset, %{"image" => image}) do
    %{size: size} = File.stat!(image.path)

    changeset
    |> validate_image_size(size, 1024)
    |> change(%{image: File.read!(image.path)})
  end

  def parse_image(changeset, _), do: changeset

  def put_code(changeset) do
    unless(get_field(changeset, :code)) do
      change(changeset, %{code: gen_code()})
    else
      changeset
    end
  end

  defp validate_image_size(changeset, size, size_limit_kb) do
    if(size / 1000 > size_limit_kb) do
      add_error(changeset, :image, dgettext("errors", "image should by smaller than %{size}", size: size_limit_kb))
    else
      changeset
    end
  end

  defp gen_code do
    Ecto.UUID.generate() |> binary_part(6, 6)
  end

  # For slugging
  # defimpl Phoenix.Param, for: Mak.Base.Machine do
  #   def to_param(%{code: code}), do: code
  # end
end
