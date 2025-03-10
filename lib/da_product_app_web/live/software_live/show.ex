defmodule DaProductAppWeb.SoftwareLive.Show do
  use DaProductAppWeb, :live_view
  alias DaProductApp.Software.SoftwareEntry

  def mount(%{"id" => id}, _session, socket) do
    software = SoftwareEntry.get_software!(id)

    {:ok, assign(socket,
      software: software,
      page_title: software.name
    )}
  end

  def render(assigns) do
    ~H"""
    <div class="container mx-auto px-4 py-8">
      <h1 class="text-2xl font-bold mb-6"><%= @software.name %></h1>

      <div class="bg-white shadow rounded-lg p-6">
        <div class="grid grid-cols-2 gap-4">
          <div>
            <h2 class="text-lg font-semibold mb-2">Details</h2>
            <p><strong>Slug:</strong> <%= @software.slug %></p>
            <p><strong>Last Updated:</strong> <%= @software.last_updated %></p>
          </div>
          <div>
            <h2 class="text-lg font-semibold mb-2">Timestamps</h2>
            <p><strong>Created:</strong> <%= @software.inserted_at %></p>
            <p><strong>Updated:</strong> <%= @software.updated_at %></p>
          </div>
        </div>
        <div class="mt-6">
          <h2 class="text-lg font-semibold mb-2">Versions</h2>
          <ul class="space-y-4">
            <%= for version <- @software.versions do %>
              <li class="border-b pb-4">
                <p><strong>Cycle:</strong> <%= version.cycle %></p>
                <p><strong>Release Date:</strong> <%= version.release_date %></p>
                <p><strong>EOL Date:</strong> <%= version.eol_date %></p>
                <p><strong>Latest Version:</strong> <%= version.latest_version %></p>
                <p><strong>Link:</strong> <a href={version.link} class="text-blue-600 hover:underline"><%= version.link %></a></p>
              </li>
            <% end %>
          </ul>
        </div>
      </div>
    </div>
    """
  end
end

