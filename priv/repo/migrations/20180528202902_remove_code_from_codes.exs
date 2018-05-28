defmodule Mak.Repo.Migrations.RemoveCodeFromCodes do
  use Ecto.Migration

  def change do
    alter table(:codes) do
      remove :code
    end
  end
end
