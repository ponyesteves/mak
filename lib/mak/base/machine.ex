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
    |> cast(attrs, [:code, :name, :desc, :image])
    |>validate_image_size(500)
    |> put_code
    |> validate_required([:code, :name, :desc])
    |> unique_constraint(:code)
  end

  defp put_code(changeset) do
    unless(get_field(changeset, :code)) do
      change(changeset, %{code: gen_code()})
    else
      changeset
    end
  end

  defp validate_image_size(changeset, size_limit_kb) do
    changeset
    |> validate_change(:image, fn(:image, image) ->
      cond do
        byte_size(image)/1000 > size_limit_kb -> [image:  dgettext("errors", "image should by smaller than %{size}", size: size_limit_kb)]
        true -> []
      end
    end)
  end

  defp gen_code do
    Ecto.UUID.generate() |> binary_part(6, 6)
  end

  # For slugging
  # defimpl Phoenix.Param, for: Mak.Base.Machine do
  #   def to_param(%{code: code}), do: code
  # end
end
