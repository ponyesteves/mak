defmodule Mak.Repo.Migrations.CreateMachines do
  use Ecto.Migration

  def change do
    create table(:machines) do
      add :code, :string
      add :name, :string
      add :desc, :string

      timestamps()
    end

  end
end
