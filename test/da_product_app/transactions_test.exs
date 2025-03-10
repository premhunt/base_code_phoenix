defmodule DaProductApp.TransactionsTest do
  use DaProductApp.DataCase

  alias DaProductApp.Transactions

  describe "transactions" do
    alias DaProductApp.Transactions.Transaction

    import DaProductApp.TransactionsFixtures

    @invalid_attrs %{status: nil, version: nil, patient_name: nil, uhid: nil, charge_rate: nil, email: nil, mobile_no: nil, processing_id: nil, uname: nil, pay_mode: nil, location_id: nil, transaction_location: nil, credentials_user: nil, credentials_key: nil, return_url: nil, response_url: nil, transaction_id: nil, transaction_amount: nil}

    test "list_transactions/0 returns all transactions" do
      transaction = transaction_fixture()
      assert Transactions.list_transactions() == [transaction]
    end

    test "get_transaction!/1 returns the transaction with given id" do
      transaction = transaction_fixture()
      assert Transactions.get_transaction!(transaction.id) == transaction
    end

    test "create_transaction/1 with valid data creates a transaction" do
      valid_attrs = %{status: "some status", version: "some version", patient_name: "some patient_name", uhid: "some uhid", charge_rate: "120.5", email: "some email", mobile_no: "some mobile_no", processing_id: "some processing_id", uname: "some uname", pay_mode: "some pay_mode", location_id: "some location_id", transaction_location: "some transaction_location", credentials_user: "some credentials_user", credentials_key: "some credentials_key", return_url: "some return_url", response_url: "some response_url", transaction_id: "some transaction_id", transaction_amount: "120.5"}

      assert {:ok, %Transaction{} = transaction} = Transactions.create_transaction(valid_attrs)
      assert transaction.status == "some status"
      assert transaction.version == "some version"
      assert transaction.patient_name == "some patient_name"
      assert transaction.uhid == "some uhid"
      assert transaction.charge_rate == Decimal.new("120.5")
      assert transaction.email == "some email"
      assert transaction.mobile_no == "some mobile_no"
      assert transaction.processing_id == "some processing_id"
      assert transaction.uname == "some uname"
      assert transaction.pay_mode == "some pay_mode"
      assert transaction.location_id == "some location_id"
      assert transaction.transaction_location == "some transaction_location"
      assert transaction.credentials_user == "some credentials_user"
      assert transaction.credentials_key == "some credentials_key"
      assert transaction.return_url == "some return_url"
      assert transaction.response_url == "some response_url"
      assert transaction.transaction_id == "some transaction_id"
      assert transaction.transaction_amount == Decimal.new("120.5")
    end

    test "create_transaction/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Transactions.create_transaction(@invalid_attrs)
    end

    test "update_transaction/2 with valid data updates the transaction" do
      transaction = transaction_fixture()
      update_attrs = %{status: "some updated status", version: "some updated version", patient_name: "some updated patient_name", uhid: "some updated uhid", charge_rate: "456.7", email: "some updated email", mobile_no: "some updated mobile_no", processing_id: "some updated processing_id", uname: "some updated uname", pay_mode: "some updated pay_mode", location_id: "some updated location_id", transaction_location: "some updated transaction_location", credentials_user: "some updated credentials_user", credentials_key: "some updated credentials_key", return_url: "some updated return_url", response_url: "some updated response_url", transaction_id: "some updated transaction_id", transaction_amount: "456.7"}

      assert {:ok, %Transaction{} = transaction} = Transactions.update_transaction(transaction, update_attrs)
      assert transaction.status == "some updated status"
      assert transaction.version == "some updated version"
      assert transaction.patient_name == "some updated patient_name"
      assert transaction.uhid == "some updated uhid"
      assert transaction.charge_rate == Decimal.new("456.7")
      assert transaction.email == "some updated email"
      assert transaction.mobile_no == "some updated mobile_no"
      assert transaction.processing_id == "some updated processing_id"
      assert transaction.uname == "some updated uname"
      assert transaction.pay_mode == "some updated pay_mode"
      assert transaction.location_id == "some updated location_id"
      assert transaction.transaction_location == "some updated transaction_location"
      assert transaction.credentials_user == "some updated credentials_user"
      assert transaction.credentials_key == "some updated credentials_key"
      assert transaction.return_url == "some updated return_url"
      assert transaction.response_url == "some updated response_url"
      assert transaction.transaction_id == "some updated transaction_id"
      assert transaction.transaction_amount == Decimal.new("456.7")
    end

    test "update_transaction/2 with invalid data returns error changeset" do
      transaction = transaction_fixture()
      assert {:error, %Ecto.Changeset{}} = Transactions.update_transaction(transaction, @invalid_attrs)
      assert transaction == Transactions.get_transaction!(transaction.id)
    end

    test "delete_transaction/1 deletes the transaction" do
      transaction = transaction_fixture()
      assert {:ok, %Transaction{}} = Transactions.delete_transaction(transaction)
      assert_raise Ecto.NoResultsError, fn -> Transactions.get_transaction!(transaction.id) end
    end

    test "change_transaction/1 returns a transaction changeset" do
      transaction = transaction_fixture()
      assert %Ecto.Changeset{} = Transactions.change_transaction(transaction)
    end
  end
end
