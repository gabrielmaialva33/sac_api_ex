defmodule SacApiEx.Repo.Migrations.CreateUsersTable do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :uuid, primary_key: true, null: false, default: fragment("uuid_generate_v4()")

      add :first_name, :string, size: 100, null: false
      add :last_name, :string, size: 100, null: false
      add :username, :string, size: 50, null: false
      add :email, :string, null: false
      add :crypted_password, :string, null: false

      add :is_online, :boolean, default: false, null: false
      add :is_blocked, :boolean, default: false, null: false
      add :is_deleted, :boolean, default: false, null: false

      timestamps()
    end

    create unique_index(:users, [:email])
    create unique_index(:users, [:username])
  end
end
