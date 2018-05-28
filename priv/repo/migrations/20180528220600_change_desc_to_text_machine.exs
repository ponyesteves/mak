defmodule Mak.Repo.Migrations.ChangeDescToTextMachine do
  use Ecto.Migration

  def change do
    alter table(:machines) do
      modify :desc, :text
    end
  end
end
