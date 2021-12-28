defmodule SacApiEx.Repo.Migrations.CreateTroublesReportsTable do
  use Ecto.Migration

  def change do
    create table(:websites_troubles, primary_key: false) do
      add :id, :uuid, primary_key: true, null: false, default: fragment("uuid_generate_v4()")

      add :website_id,
          references(:websites, type: :uuid, column: :id, on_delete: :delete_all),
          null: false

      add :trouble_id,
          references(:troubles, type: :uuid, column: :id, on_delete: :delete_all),
          null: false

      add :type, :string, null: false, default: "common"

      timestamps()
    end

    create index(:websites_troubles, [:website_id])
    create index(:websites_troubles, [:trouble_id])

    create(
      unique_index(
        :websites_troubles,
        [:website_id, :trouble_id],
        name: :website_id_trouble_id_unique_index
      )
    )
  end
end
