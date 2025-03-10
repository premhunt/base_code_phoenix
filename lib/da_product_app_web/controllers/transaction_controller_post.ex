defmodule DaProductAppWeb.TransactionPostController do
  use DaProductAppWeb, :controller

  # Explicitly skip CSRF protection for the new action.
 # plug :protect_from_forgery, except: [:new]

  alias DaProductApp.Transactions
  alias DaProductApp.Transactions.Transaction

  def new(conn, params) do
    # Parse the JSON data from the "token" parameter.
    parsed =
      case Jason.decode(params["token"]) do
        {:ok, data} -> data
        _error -> %{}
      end

    # Extract account info (assumes one account record exists)
    account = List.first(parsed["accounts"] || []) || %{}

    # Build the attribute map for transaction insertion. Adjust keys/defaults as needed.
    transaction_attrs = %{
      "patient_name" => account["patient_name"] |> String.replace_prefix("Name: ", "") |> String.trim(),
      "uhid" => account["account_number"] |> String.replace_prefix("UHID: ", "") |> String.trim(),
      "charge_rate" => account["amount"],
      "email" => account["email"] || "",
      "mobile_no" => account["phone"] || "",
      "processing_id" => parsed["processing_id"] || "",
      "uname" => parsed["username"] || "",
      "pay_mode" => parsed["paymode"] || "",
      # If "location_id" is not provided in params, default to an empty string.
      "location_id" => params["location_id"] || "",
      "transaction_location" => parsed["payment_location"] || "",
      "credentials_user" => get_in(parsed, ["auth", "user"]) || "",
      "credentials_key" => get_in(parsed, ["auth", "key"]) || "",
      "version" => params["version"] || "",
      "return_url" => params["return_url"] || "",
      "response_url" => params["response_url"] || "",
      "status" => "pending"
    }

    case Transactions.Transaction.get_transaction_by_processing_id(transaction_attrs["processing_id"]) do
      nil ->
        case Transactions.Transaction.create_transaction(transaction_attrs) do
          {:ok, transaction} ->
            conn
            |> put_session(:transaction_id, transaction.id)
            |> redirect(to: "/transactions/#{transaction.id}")

          {:error, changeset} ->
            conn
            |> send_resp(400, "Error inserting transaction: #{inspect(changeset.errors)}")
        end

      transaction ->
        conn
        |> put_session(:transaction_id, transaction.id)
        |> redirect(to: "/transactions/#{transaction.id}")
    end
  end

end

