defmodule SacApiEx.Repo.Migrations.CreateTroublesTable do
  use Ecto.Migration

  def change do
    create table(:troubles, primary_key: false) do
      add :id, :uuid, primary_key: true, null: false, default: fragment("uuid_generate_v4()")

      add :title, :string, null: false
      add :description, :text
      add :type, :string, null: false, default: "common"

      add :is_deleted, :boolean, default: false, null: false

      timestamps()
    end
  end
end
