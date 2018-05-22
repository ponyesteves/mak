defmodule Mak.Repo.Migrations.AddImageBinaryToRemachines do
  use Ecto.Migration

  def change do
    alter table(:machines) do
      add :image, :binary
    end
  end
end
