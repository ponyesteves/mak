defmodule Mak.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string
      add :password_hash, :string
      add :admin, :boolean
      add :email, :string
      timestamps()
    end

  end
end
