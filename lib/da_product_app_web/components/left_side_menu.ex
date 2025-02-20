defmodule DaProductAppWeb.Components.LeftSideMenu do
  use Phoenix.LiveComponent

#use Phoenix.Component

  slot :extra_menu, required: false
  slot :main_menu, required: true

  def render(assigns) do
    ~H"""
    <!-- Main Sidebar -->
    <aside id="left-side-menu"  class="bg-gray-900 text-white w-64 min-h-screen p-4 shadow-lg">
      <!-- Sidebar Header -->
      <div class="flex flex-col items-center">
        <!-- Large Logo -->
        <a href="#" class="hidden sm:block">
          <img src="/images/momentpay.png" class="w-48 mt-2" alt="MomentPay Logo">
        </a>
        <!-- Small Logo -->
        <a href="#" class="block sm:hidden">
          <img src="/images/momentpay.png" class="w-8 h-8 mt-2" alt="MomentPay Logo">
        </a>
      </div>

      <!-- Extra Menu Dropdown -->
      <%= if assigns[:extra_menu] do %>
        <div class="relative mt-4">
          <button class="p-2 w-full flex justify-between bg-gray-800 hover:bg-gray-700 rounded">
            <span>Extra Menu</span>
            <i class="lucide lucide-chevron-down"></i>
          </button>
          <div class="absolute left-0 mt-2 w-full bg-gray-800 rounded shadow-lg hidden group-hover:block">
            <%= render_slot(@extra_menu) %>
          </div>
        </div>
      <% end %>

      <!-- Main Menu -->
      <nav class="mt-4">
        <%= render_slot(@main_menu) %>
      </nav>
    </aside>
    """
  end
end

