defmodule Mak.Repo.Migrations.CreateMachines do
  use Ecto.Migration

  def change do
    create table(:machines, primary_key: false) do
      add :id, :string, primary_key: true
      add :name, :string
      add :desc, :text

      timestamps()
    end

  end
end
