defmodule Mak.Repo.Migrations.CreateCodes do
  use Ecto.Migration

  def change do
    create table(:codes) do
      add :name, :string
      add :scope, :string

      timestamps()
    end

  end
end
