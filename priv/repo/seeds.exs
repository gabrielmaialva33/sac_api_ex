# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     SacApiEx.Repo.insert!(%SacApiEx.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias SacApiEx.User.Models.Role
alias SacApiEx.Repo

if Mix.env() == :dev do
  Repo.insert!(%Role{slug: "Root", name: "root", description: "root role"})
  Repo.insert!(%Role{slug: "Admin", name: "admin", description: "admin role"})
  Repo.insert!(%Role{slug: "User", name: "user", description: "user role"})
  Repo.insert!(%Role{slug: "Guest", name: "guest", description: "guest role"})
end

if Mix.env() == :test do
  Repo.insert!(%Role{slug: "Root", name: "root", description: "root role"})
  Repo.insert!(%Role{slug: "Admin", name: "admin", description: "admin role"})
  Repo.insert!(%Role{slug: "User", name: "user", description: "user role"})
  Repo.insert!(%Role{slug: "Guest", name: "guest", description: "guest role"})
end
