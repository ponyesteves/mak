defmodule Mak.Repo.Migrations.AddStatusToOrders do
  use Ecto.Migration

  def change do
    alter table(:orders) do
      add :status_id, :integer
    end
  end
end
