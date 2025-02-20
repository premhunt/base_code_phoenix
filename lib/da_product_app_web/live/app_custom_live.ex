defmodule DaProductAppWeb.AppCustomLiveView do
  use DaProductAppWeb, :live_view


  def mount(_params, _session, socket) do
    {:ok, assign(socket, sidebar_open: false)}
  end

  def handle_event("toggle_sidebar", _params, socket) do
    {:noreply, assign(socket, sidebar_open: !socket.assigns.sidebar_open)}
  end
end

