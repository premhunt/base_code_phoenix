defmodule DaProductAppWeb.Components.BaseLayout do
  use Phoenix.LiveComponent


  slot :pageheader, required: false
  slot :navbar, required: false
  slot :left_side_menu, required: false
  slot :right_part, required: false
  slot :content, required: true
  slot :extra_body, required: false
  slot :footer, required: false

  def render(assigns) do
    ~H"""
    <div class="flex min-h-screen flex-col">
      <%= render_slot(@navbar) || live_component(DaProductAppWeb.Components.Navbar) %>

      <div class="flex flex-grow">
        <aside class="w-64 bg-gray-100 p-4">
          <%= render_slot(@left_side_menu) || live_component(DaProductAppWeb.Components.LeftSideMenu) %>
        </aside>

        <main class="flex-grow p-4">
          <%= render_slot(@pageheader) || live_component(DaProductAppWeb.Components.PageHeader) %>
          <%= render_slot(@content) %>
          <%= render_slot(@extra_body) %>
        </main>
      </div>

      <%= render_slot(@footer) || live_component(DaProductAppWeb.Components.Footer) %>
    </div>
    """
  end
end

