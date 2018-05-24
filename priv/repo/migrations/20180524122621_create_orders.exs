defmodule Mak.Repo.Migrations.CreateOrders do
  use Ecto.Migration

  def change do
    create table(:orders) do
      add :date, :date
      add :title, :string
      add :desc, :string
      add :type_id, references(:types, on_delete: :nothing)
      add :machine_id, references(:machines, on_delete: :nothing)
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:orders, [:type_id])
    create index(:orders, [:machine_id])
    create index(:orders, [:user_id])
  end
end
