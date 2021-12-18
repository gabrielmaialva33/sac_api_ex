defmodule SacApiEx.Repo.Migrations.CreateRolesTable do
  use Ecto.Migration

  def change do
    create table(:roles, primary_key: false) do
      add :id, :uuid, primary_key: true, null: false, default: fragment("uuid_generate_v4()")

      add :slug, :string, size: 50
      add :name, :string, size: 20
      add :description, :text

      timestamps
    end

    create unique_index(:roles, [:name], comment: "index role name")
  end
end
