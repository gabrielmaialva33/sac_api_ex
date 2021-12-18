defmodule SacApiEx.Repo.Migrations.CreateWebsitesTable do
  use Ecto.Migration

  def change do
    create table(:websites, primary_key: false) do
      add :id, :uuid, primary_key: true, null: false, default: fragment("uuid_generate_v4()")

      add :title, :string, null: false
      add :description, :text
      add :url, :string, null: false
      add :is_deleted, :boolean, default: false, null: false

      timestamps()
    end
  end
end
