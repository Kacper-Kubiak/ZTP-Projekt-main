# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     AuthServer.Repo.insert!(%AuthServer.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

AuthServer.Repo.insert!(%AuthServer.Accounts.User{
  clientId: "107635",
  exp: 1653478380,
  name: "Kacper Kubiak",
  secret: "11INF-ZSI-ND-secret",
  token: "11INF-ZSI-ND-token"
})
