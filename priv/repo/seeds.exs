# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Mak.Repo.insert!(%Mak.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

Mak.Repo.insert!(%Mak.Transactions.Code{name: "Reparación", scope: "type"})
Mak.Repo.insert!(%Mak.Transactions.Code{name: "Mantenimiento", scope: "type"})
Mak.Repo.insert!(%Mak.Transactions.Code{name: "Pendiente", scope: "status"})
Mak.Repo.insert!(%Mak.Transactions.Code{name: "En ejecución", scope: "status"})
Mak.Repo.insert!(%Mak.Transactions.Code{name: "Finalizada", scope: "status"})

Mak.Accounts.create_user(%{username: "admin", password: "1234"})
