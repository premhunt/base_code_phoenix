defmodule DaProductAppWeb.Components.Footer do
#  use Phoenix.Component
  use Phoenix.LiveComponent


  attr :version, :string, default: "1.0.0"

  def render(assigns) do
    ~H"""
    <footer id="app-footer" class="bg-gray-800 text-gray-400 text-sm p-4 mt-6">
      <div class="container mx-auto flex justify-between">
        <div>
          &copy; <%= Date.utc_today().year %> MyApp. All rights reserved.
        </div>
        <div class="text-right">
          v<%= @version %>
        </div>
      </div>
    </footer>
    """
  end
end

