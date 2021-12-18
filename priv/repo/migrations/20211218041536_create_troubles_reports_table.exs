defmodule SacApiEx.Repo.Migrations.CreateTroublesReportsTable do
  use Ecto.Migration

  def change do
    create table(:websites_troubles, primary_key: false) do
      add :trouble_id, references(:troubles, type: :uuid, column: :id, on_delete: :delete_all),
        null: false

      add :website_id, references(:websites, type: :uuid, column: :id, on_delete: :delete_all),
        null: false

      timestamps()
    end
  end
end
