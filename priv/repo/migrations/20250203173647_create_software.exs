defmodule DaProductApp.Repo.Migrations.CreateSoftware do
  use Ecto.Migration

   def change do
    create table(:software) do
      add :name, :string, null: false
      add :slug, :string, null: false, unique: true
      add :last_updated, :utc_datetime
      timestamps()
    end

    create unique_index(:software, [:slug])
  end
end
