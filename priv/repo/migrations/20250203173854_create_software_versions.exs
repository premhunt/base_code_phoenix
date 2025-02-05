defmodule DaProductApp.Repo.Migrations.CreateSoftwareVersions do
  use Ecto.Migration

   def change do
    create table(:software_versions) do
      add :software_id, references(:software, on_delete: :delete_all), null: false
      add :cycle, :string, null: false
      add :release_date, :date
      add :eol_date, :date
      add :latest_version, :string
      timestamps()
    end

    create index(:software_versions, [:software_id])
  end
end
