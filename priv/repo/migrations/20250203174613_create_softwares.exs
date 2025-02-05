defmodule DaProductApp.Repo.Migrations.CreateSoftwares do
  use Ecto.Migration

  def change do
    create table(:softwares, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :slug, :string
      add :last_updated, :utc_datetime

      timestamps(type: :utc_datetime)
    end
  end
end
