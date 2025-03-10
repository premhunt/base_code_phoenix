defmodule DaProductAppWeb.SidebarComponent do
  use Phoenix.LiveComponent
  use DaProductAppWeb, :verified_routes
   use PetalComponents

  def update(assigns, socket) do
    socket =
      socket
      |> assign(:collapsed, assigns[:collapsed] || false)
      |> assign(:menu_data, @menu_data)

    {:ok, socket}
  end

def render(assigns) do
    ~H"""
      <div class="w-48 bg-gray-100 h-screen fixed left-0 top-0 pt-16 p-4">
 <div class="mt-[-2.5rem] mb-6">
    <img src="https://aritic.com/wp-content/uploads/2019/08/aritic-logo.png" alt="Logo" class="w-32 h-auto">
  </div>
   <.vertical_menu
    title="Main menu"
    menu_items={[
      %{
        title: "Main",
        menu_items: [
      %{
        name: :dashboard,
        label: "Dashboard",
        path: ~p"/dashboard",
        icon: "hero-home"
      },
      %{name: :software, label: "Application", path: ~p"/software", icon: "hero-lifebuoy"},
      %{name: :settings, label: "Artificates", path: ~p"/users/settings", icon: "hero-cog"},
      %{
        name: :settings,
        label: "Settings",
        path: ~p"/users/settings",
        icon: "hero-circle-stack",
        menu_items: [
          %{
            name: :sbomcomponent,
            label: "Components",
            path: ~p"/sbomcomponent",
            icon: "hero-archive-box"
          },
          %{
            name: :settings,
            label: "Users",
            path: ~p"/users/settings",
            icon: "hero-arrow-down-on-square-stack"
          },
        ]
      },
  
       %{
        name: :settings,
        label: "Tools",
        path: ~p"/dashboard",
        icon: "hero-wrench"
      },
    ]
      },
      %{
        title: "User",
        menu_items: [
          %{
            name: :settings,
            label: "Profile",
            path: ~p"/users/settings",
            icon: "hero-cog-6-tooth"
          },
        ]
      }
    ]}
    current_page={:dashboard}
  />
</div>


    """
 end
end
