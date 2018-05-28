defmodule Mak.Repo.Migrations.AddScopeToCodes do
  use Ecto.Migration

  def change do
    alter table(:codes) do
      add :scope, :string
    end
  end
end
