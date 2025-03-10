defmodule DaProductApp.TransactionsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `DaProductApp.Transactions` context.
  """

  @doc """
  Generate a transaction.
  """
  def transaction_fixture(attrs \\ %{}) do
    {:ok, transaction} =
      attrs
      |> Enum.into(%{
        charge_rate: "120.5",
        credentials_key: "some credentials_key",
        credentials_user: "some credentials_user",
        email: "some email",
        location_id: "some location_id",
        mobile_no: "some mobile_no",
        patient_name: "some patient_name",
        pay_mode: "some pay_mode",
        processing_id: "some processing_id",
        response_url: "some response_url",
        return_url: "some return_url",
        status: "some status",
        transaction_amount: "120.5",
        transaction_id: "some transaction_id",
        transaction_location: "some transaction_location",
        uhid: "some uhid",
        uname: "some uname",
        version: "some version"
      })
      |> DaProductApp.Transactions.create_transaction()

    transaction
  end
end
