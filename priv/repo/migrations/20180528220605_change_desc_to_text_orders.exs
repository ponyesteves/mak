defmodule Mak.Repo.Migrations.ChangeDescToTextOrders do
  use Ecto.Migration

  def change do
    alter table(:orders) do
      modify :desc, :text
    end
  end
end
