defmodule DaProductApp.Repo.Migrations.CreateComponents do
  use Ecto.Migration

  def change do
    create table(:components, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :component_name, :string
      add :version, :string
      add :supplier_type, :string
      add :supplier_name, :string
      add :relationship, :string
      add :checksum_type, :string
      add :checksum_algorithm, :string
      add :checksum_value, :string
      add :user_id, :integer
      add :application_id, :integer
      add :organization_id, :integer

      timestamps(type: :utc_datetime)
    end
  end
end
