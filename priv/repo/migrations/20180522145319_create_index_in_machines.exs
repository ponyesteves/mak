defmodule Mak.Repo.Migrations.CreateIndexInMachines do
  use Ecto.Migration
  def change do
    create unique_index(:machines, :code)
  end
end
