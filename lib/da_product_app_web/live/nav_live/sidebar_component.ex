defmodule DaProductAppWeb.NavLive.SidebarComponent do
  use Phoenix.LiveComponent

  def render(assigns) do
    ~H"""
    <nav class="sidebar">
      <ul>
        <li><a href="/">Home</a></li>
        <li><a href="/about">About</a></li>
        <li><a href="/services">Services</a></li>
        <li><a href="/contact">Contact</a></li>
      </ul>
    </nav>
    """
  end
end

