defmodule DaProductApp.Repo.Migrations.AddNameFieldsToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :role, :string, default: "user", null: false
      add :first_name, :string
      add :last_name, :string
      add :name, :string
      add :image, :string

      add :data, :map
    end

   execute """
    ALTER TABLE users
    ADD COLUMN data_name VARCHAR(255) GENERATED ALWAYS AS (data->>'$.name') STORED;
    """

   create index(:users, [:data_name], name: :users_data_name_index)

   # create index(:users, :data, using: "gin")
  end
end
