defmodule DaProductApp.Repo.Migrations.CreateTransactions do
  use Ecto.Migration

  def change do
    create table(:transactions, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :patient_name, :string
      add :uhid, :string
      add :charge_rate, :decimal
      add :email, :string
      add :mobile_no, :string
      add :processing_id, :string
      add :uname, :string
      add :pay_mode, :string
      add :location_id, :string
      add :transaction_location, :string
      add :credentials_user, :string
      add :credentials_key, :string
      add :version, :string
      add :return_url, :string
      add :response_url, :string
      add :status, :string
      add :transaction_id, :string
      add :transaction_amount, :decimal

      timestamps(type: :utc_datetime)
    end
  end
end
