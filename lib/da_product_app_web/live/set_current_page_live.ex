defmodule DaProductAppWeb.Live.SetCurrentPage do
  import Phoenix.LiveView, only: [assign: 3]  # Ensure assign/3 is imported
   import Phoenix.Component, only: [assign: 3]

  def on_mount(_params, _session, socket) do
    {:cont, assign(socket, :current_page, determine_current_page(socket))}
  end

  defp determine_current_page(socket) do
    case socket.assigns.live_action do
      :dashboard -> :dashboard
   #   :software -> :software
      :settings -> :settings
      _ -> nil
    end
  end
end

