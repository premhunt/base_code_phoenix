defmodule DaProductAppWeb.SoftwareLive do
  use DaProductAppWeb, :live_view
  alias DaProductApp.Software.SoftwareEntry

  def mount(_params, _session, socket) do
    software_list = 
      SoftwareEntry.list_software() 
      |> Enum.map(fn software -> %{
        id: software.id,
        name: %{id: software.id, name: software.name},
        slug: software.slug,
        last_updated: DateTime.to_iso8601(software.last_updated),
        inserted_at: DateTime.to_iso8601(software.inserted_at),
        updated_at: DateTime.to_iso8601(software.updated_at)
      } end)

    {:ok, assign(socket, 
      software_list: software_list,
      page_title: "Software List"
    )}
  end

  def render(assigns) do
    ~H"""
    <div class="software-grid-wrapper">
      <h1 class="text-2xl font-bold mb-6">Software List</h1>
      
      <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4 mb-8">
        <.review_card 
          name="Anne"
          username="@anne"
          body="I've never seen anything like this before. It's amazing."
          img="https://res.cloudinary.com/wickedsites/image/upload/v1604268092/unnamed_sagz0l.jpg"
        />
        
        <.review_card 
          name="John"
          username="@john"
          body="This product is a game-changer!"
          img="https://res.cloudinary.com/wickedsites/image/upload/v1604268092/unnamed_sagz0l.jpg"
        />

        <.review_card 
          name="Emma"
          username="@emma"
          body="Highly recommend this to everyone."
          img="https://res.cloudinary.com/wickedsites/image/upload/v1604268092/unnamed_sagz0l.jpg"
        />

        <.review_card 
          name="Mike"
          username="@mike"
          body="Absolutely love this! Five stars!"
          img="https://res.cloudinary.com/wickedsites/image/upload/v1604268092/unnamed_sagz0l.jpg"
        />
      </div>

      <div 
        id="softwareGrid" 
        class="software-grid ag-theme-alpine" 
        phx-hook="SoftwareAgGrid"
        data-software={Jason.encode!(@software_list)}
        data-target="#softwareGridContainer"
      >
        <div id="softwareGridContainer"></div>
      </div>
    </div>
    """
  end
end
