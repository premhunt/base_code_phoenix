# filepath: lib/da_product_app/transactions/transaction.ex
defmodule DaProductApp.Transactions.Transaction do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, only: [from: 2]

  @primary_key {:id, :id, autogenerate: true}
  schema "transactions" do
    field :patient_name, :string
    field :uhid, :string
    field :charge_rate, :decimal
    field :email, :string
    field :mobile_no, :string
    field :processing_id, :string
    field :uname, :string
    field :pay_mode, :string
    field :location_id, :string
    field :transaction_location, :string
    field :credentials_user, :string
    field :credentials_key, :string
    field :version, :string
    field :return_url, :string
    field :response_url, :string
    field :status, :string, default: "pending"
    field :transaction_id, :string
    field :transaction_amount, :decimal

    timestamps()
  end

  @doc false
  def changeset(transaction, attrs) do
    transaction
    |> cast(attrs, [
      :patient_name, :uhid, :charge_rate, :email, :mobile_no,
      :processing_id, :uname, :pay_mode, :location_id,
      :transaction_location, :credentials_user, :credentials_key,
      :version, :return_url, :response_url, :status,
      :transaction_id, :transaction_amount
    ])
    |> maybe_set_default_email()
    |> validate_required([
      :patient_name, :uhid, :charge_rate, :processing_id, :uname, :pay_mode,
      :transaction_location, :credentials_user, :credentials_key
    ])
  end

  # If email is blank, generate a default value.
  defp maybe_set_default_email(changeset) do
    if get_field(changeset, :email) in [nil, ""] do
      default_email =
        "ch_" <>
        (:crypto.strong_rand_bytes(6) |> Base.encode16(case: :lower)) <>
        "@momentpay.in"

      put_change(changeset, :email, default_email)
    else
      changeset
    end
  end

  def get_transaction_by_processing_id(nil), do: nil
  def get_transaction_by_processing_id(processing_id) when is_binary(processing_id) do
    from(t in __MODULE__, where: t.processing_id == ^processing_id)
    |> DaProductApp.Repo.one()
  end

  def create_transaction(attrs \\ %{}) do
    %__MODULE__{}
    |> changeset(attrs)
    |> DaProductApp.Repo.insert()
  end
end

