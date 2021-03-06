defmodule SacApiEx.Repo.Migrations.CreateReportsTable do
  use Ecto.Migration

  def change do
    create table(:reports, primary_key: false) do
      add :id, :uuid, primary_key: true, null: false, default: fragment("uuid_generate_v4()")

      add :trouble_id, references(:troubles, type: :uuid, column: :id, on_delete: :delete_all),
        null: false

      add :is_reported, :boolean, default: true, null: false

      timestamps()
    end
  end
end
