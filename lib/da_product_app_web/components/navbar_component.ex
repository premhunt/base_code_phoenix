defmodule DaProductAppWeb.NavbarComponent do
  use Phoenix.LiveComponent
  use DaProductAppWeb, :verified_routes
  use PetalComponents


  def update(assigns, socket) do
    socket = assign_new(socket, :current_user, fn -> assigns[:current_user] end)
    {:ok, socket}
  end


  def render(assigns) do
    ~H"""
    <div>
    <!-- Navbar -->
    <header class="fixed top-0 lg:left-48 right-0 bg-white shadow px-4 sm:px-6 lg:px-8 h-12 flex items-center justify-end z-50">
      <ul class="flex items-center gap-4">
        <%= if @current_user do %>
          <li class="flex items-center gap-2 text-sm text-zinc-900">
            <.icon name="hero-user" class="h-5 w-5" />
            <%= @current_user.email %>
          </li>
          <li>
            <.link href={~p"/users/settings"} class="flex items-center gap-2 text-sm font-semibold text-zinc-900 hover:text-zinc-700">
              <.icon name="hero-cog" class="h-5 w-5" /> Settings
            </.link>
          </li>
          <li>
            <.link href={~p"/users/log_out"} method="delete" class="flex items-center gap-2 text-sm font-semibold text-zinc-900 hover:text-zinc-700">
              <.icon name="hero-home" class="h-5 w-5" /> Log out
            </.link>
          </li>
        <% else %>
          <li>
            <.link href={~p"/users/register"} class="flex items-center gap-2 text-sm font-semibold text-zinc-900 hover:text-zinc-700">
              <.icon name="hero-academic-cap" class="h-5 w-5" /> Register
            </.link>
          </li>
          <li>
            <.link href={~p"/users/log_in"} class="flex items-center gap-2 text-sm font-semibold text-zinc-900 hover:text-zinc-700">
              <.icon name="hero-arrow-right-circle" class="h-5 w-5" /> Log in
            </.link>
          </li>
        <% end %>
      </ul>
    </header>
    </div>
    """
  end
end

