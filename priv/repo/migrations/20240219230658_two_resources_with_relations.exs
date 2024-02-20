defmodule RelationshipTest.Repo.Migrations.TwoResourcesWithRelations do
  @moduledoc """
  Updates resources based on their most recent snapshots.

  This file was autogenerated with `mix ash_postgres.generate_migrations`
  """

  use Ecto.Migration

  def up do
    create table(:users, primary_key: false) do
      add :id, :uuid, null: false, default: fragment("uuid_generate_v4()"), primary_key: true
      add :name, :text, null: false
      add :email, :citext, null: false
    end

    create table(:messages, primary_key: false) do
      add :id, :uuid, null: false, default: fragment("uuid_generate_v4()"), primary_key: true
      add :content, :text, null: false

      add :user_id,
          references(:users,
            column: :id,
            name: "messages_user_id_fkey",
            type: :uuid,
            prefix: "public"
          ),
          null: false
    end
  end

  def down do
    drop constraint(:messages, "messages_user_id_fkey")

    drop table(:messages)

    drop table(:users)
  end
end