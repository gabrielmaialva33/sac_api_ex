defmodule SacApiEx.Repo.Migrations.CreateRolesUsersTable do
  use Ecto.Migration

  def change do
    create table(:roles_users, primary_key: false) do
      add :id, :uuid, primary_key: true, null: false, default: fragment("uuid_generate_v4()")

      add :role_id, references(:roles, type: :uuid, column: :id, on_delete: :delete_all),
        null: false

      add :user_id, references(:users, type: :uuid, column: :id, on_delete: :delete_all),
        null: false

      timestamps
    end

    create unique_index(:roles_users, [:role_id, :user_id])
  end
end
