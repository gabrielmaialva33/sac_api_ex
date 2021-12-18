defmodule SacApiEx.Repo.Migrations.CreateTroublesReportsTable do
  use Ecto.Migration

  def change do
    create table(:troubles_reports, primary_key: false) do
      add :trouble_id, references(:troubles, type: :uuid, column: :id, on_delete: :delete_all),
        null: false

      add :report_id, references(:reports, type: :uuid, column: :id, on_delete: :delete_all),
        null: false
    end
  end
end
