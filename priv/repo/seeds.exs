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

alias SacApiEx.User.Repositories.RolesRepository

if Mix.env() == :dev do
  RolesRepository.create_role(%{slug: "Root", name: "root", description: "root role"})
  RolesRepository.create_role(%{slug: "Admin", name: "admin", description: "admin role"})
  RolesRepository.create_role(%{slug: "User", name: "user", description: "user role"})
  RolesRepository.create_role(%{slug: "Guest", name: "guest", description: "guest role"})
end

if Mix.env() == :test do
  RolesRepository.create_role(%{slug: "Root", name: "root", description: "root role"})
  RolesRepository.create_role(%{slug: "Admin", name: "admin", description: "admin role"})
  RolesRepository.create_role(%{slug: "User", name: "user", description: "user role"})
  RolesRepository.create_role(%{slug: "Guest", name: "guest", description: "guest role"})
end
