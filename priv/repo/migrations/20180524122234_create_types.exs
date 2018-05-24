defmodule Mak.Repo.Migrations.CreateTypes do
  use Ecto.Migration

  def change do
    create table(:types) do
      add :code, :string
      add :g, :string
      add :name, :string

      timestamps()
    end

  end
end
