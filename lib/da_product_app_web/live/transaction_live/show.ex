defmodule DaProductAppWeb.TransactionLive.Show do
  use DaProductAppWeb, :live_view
  alias DaProductApp.Transactions

  def mount(%{"id" => transaction_id}, session, socket) do
    if connected?(socket), do: DaProductAppWeb.Endpoint.subscribe("transaction:#{transaction_id}")

    transaction = Transactions.get_transaction!(transaction_id)

    {:ok, assign(socket, transaction: transaction)}
  end

  def handle_info(%{event: "transaction_updated", payload: updated_tx}, socket) do
    {:noreply, assign(socket, transaction: updated_tx)}
  end

  def render(assigns) do
    ~H"""
    <div class="container mx-auto px-4 py-8">
      <h1 class="text-2xl font-bold mb-6">Transaction Details</h1>
      <div class="bg-white shadow rounded-lg p-6">
        <p><strong>Patient Name:</strong> <%= @transaction.patient_name %></p>
        <p><strong>Status:</strong> <%= @transaction.status %></p>
        <p><strong>Transaction ID:</strong> <%= @transaction.transaction_id %></p>
        <p><strong>Amount:</strong> <%= @transaction.transaction_amount %></p>
        <!-- Add additional fields as needed -->
      </div>
    </div>
    """
  end
end
