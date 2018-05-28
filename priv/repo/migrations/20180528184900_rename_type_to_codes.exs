defmodule Mak.Repo.Migrations.RenameTypeToCodes do
  use Ecto.Migration

  def change do
    rename table(:types), to: table(:codes)
  end
end
