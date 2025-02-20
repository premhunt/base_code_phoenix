defmodule DaProductAppWeb.DashboardLive do
  use DaProductAppWeb, :live_view
  import Logger
  alias DaProductApp.Users

 # on_mount DaProductAppWeb.Live.SetCurrentPage
  def mount(_params, session, socket) do
     user_token = session["user_token"] 
    user = user_token && Users.get_user_by_session_token(user_token)

    current_user = user || nil
    Logger.debug("Socket Assigns: #{inspect(socket.assigns)}", []) # Correct usage

    #current_user = Map.get(session, "current_user", nil)

    socket =
      socket
      |> assign(:current_user, current_user)
      |> assign(:show_sidebar, true)  # Enable sidebar for dashboard
      |> assign(:page_title, "Dashboard")  # Set the page title

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
        <p>Welcome to the dashboard, <%= @current_user && @current_user.email || "Guest" %>!</p>
    """
  end
end

