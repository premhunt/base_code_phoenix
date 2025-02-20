defmodule DaProductAppWeb.Components.PageHeader do
  use Phoenix.LiveComponent

#use Phoenix.Component

  slot :title, required: true
  slot :description, required: false
  slot :publish_status, required: false
  slot :custom_left, required: false
  slot :actions, required: false
  slot :toolbar, required: false
  slot :custom_right, required: false

  def render(assigns) do
    ~H"""
    <div class="grid grid-cols-2 mb-4">
      <!-- Left Side -->
      <div>
        <h3 class="text-2xl font-semibold"><%= render_slot(@title) %></h3>
        <p class="text-sm text-gray-600"><%= render_slot(@description) %></p>
        <%= render_slot(@publish_status) %>
        <%= render_slot(@custom_left) %>
      </div>

      <!-- Right Side (Toolbar) -->
      <div class="text-right">
        <%= render_slot(@actions) %>

        <div class="inline-flex space-x-2">
          <%= render_slot(@toolbar) %>
        </div>

        <%= render_slot(@custom_right) %>
      </div>
    </div>
    """
  end
end

