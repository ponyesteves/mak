defmodule Mak.Base.Machine do
  use Ecto.Schema
  import Ecto.Changeset
  import MakWeb.Gettext, only: [dgettext: 3]

  @primary_key {:id, :string, []}
  # @derive {Phoenix.Param, key: :id}

  schema "machines" do
    field(:desc, :string)
    field(:name, :string)
    field(:image, :binary)
    has_many(:orders, Mak.Transactions.Order)

    timestamps()
  end

  @doc false
  def changeset(machine, attrs) do
    machine
    |> cast(attrs, [:id, :name, :desc, :image])
    |> validate_image_size(500)
    |> validate_required([:name, :desc])
    |> validate_format(:id, ~r/^\d{7,8}$/)
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
end
