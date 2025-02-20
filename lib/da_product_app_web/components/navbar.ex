defmodule DaProductAppWeb.Components.Navbar do
  use Phoenix.LiveComponent

#use Phoenix.Component

  slot :notifications, required: false
  slot :profile_menu, required: false

  def render(assigns) do
    ~H"""
    <!-- Main Header -->
    <header id="header_main" class="bg-gray-900 text-white shadow-md">
      <div class="loading-bar hidden">Loading...</div>
      <div class="flex items-center justify-between p-4">
        <!-- Sidebar Toggles -->
        <div class="flex items-center space-x-4">
          <button id="sidebar_main_toggle" class="p-2 rounded hover:bg-gray-700">
            <i class="lucide lucide-menu"></i>
          </button>
          <button id="sidebar_secondary_toggle" class="p-2 rounded hover:bg-gray-700">
            <i class="lucide lucide-activity"></i>
          </button>
        </div>

        <!-- User Actions -->
        <ul class="flex items-center space-x-4">
          <!-- Full Screen Toggle -->
          <li>
            <button id="full_screen_toggle" phx-click="toggle_fullscreen" class="p-2 rounded hover:bg-gray-700">
              <i class="lucide lucide-maximize"></i>
            </button>
          </li>

          <!-- Search -->
          <li>
            <button id="main_search_btn" class="p-2 rounded hover:bg-gray-700">
              <i class="lucide lucide-search"></i>
            </button>
          </li>

          <!-- Notifications -->
          <li class="relative">
            <%= render_slot(@notifications) %>
          </li>

          <!-- Profile Menu -->
          <li class="relative">
            <%= render_slot(@profile_menu) %>
          </li>

          <!-- Settings -->
          <li>
            <button id="style_switcher_toggle_new" class="p-2 rounded hover:bg-gray-700">
              <i class="lucide lucide-settings"></i>
            </button>
          </li>
        </ul>
      </div>

      <!-- Search Bar -->
      <div class="hidden" id="header_main_search_form">
        <form class="flex items-center bg-white p-2 shadow-md">
          <input type="search" id="globalSearchInput" name="global_search"
                 placeholder="Search everything..."
                 class="flex-grow p-2 border rounded">
          <button type="submit" class="p-2">
            <i class="lucide lucide-search"></i>
          </button>
        </form>
      </div>
    </header>
    """
  end
end

