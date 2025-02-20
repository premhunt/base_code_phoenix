defmodule DaProductAppWeb.SbomComponentOldLive do
  use DaProductAppWeb, :live_view
  import Logger
  alias DaProductApp.Users
  alias DaProductAppWeb.Router.Helpers, as: Routes
 # on_mount DaProductAppWeb.Live.SetCurrentPage



  @impl true
def mount(_params, session, socket) do
  changeset = build_changeset()
  current_user = session["user_token"]
                |> Users.get_user_by_session_token()
                || nil

  socket =
    socket
    |> assign(:current_user, current_user)
    |> assign(:show_sidebar, true)  # Enable sidebar for dashboard
    |> assign(:page_title, "SBOM Component")  # Set the page title

  {:ok,
   assign(socket,
     modal: false,
     slide_over: false,
     group_size: "md",
     pagination_page: 1,
     total_pages: 10,
     form: to_form(changeset, as: :object),
     form2: to_form(changeset, as: :object2),
     show_childbom_spdx: false, 
     show_checksum_details: false,
     active_tab: :live
   )}
end
def handle_event("toggle_childbom", _params, socket) do
    new_value = !socket.assigns.show_childbom_spdx
    {:noreply, assign(socket, show_childbom_spdx: new_value)}
  end

  def handle_event("toggle_checksum_type", %{"value" => "File"}, socket) do
    {:noreply, assign(socket, show_checksum_details: true)}
  end

  def handle_event("toggle_checksum_type", _params, socket) do
    {:noreply, assign(socket, show_checksum_details: false)}
  end

   @impl true
  def handle_event("validate", %{"object" => object_params}, socket) do
    changeset =
      object_params
      |> build_changeset()
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  @impl true
  def handle_event("submit", %{"object" => object_params}, socket) do
    changeset = build_changeset(object_params)

    case validate_changeset(changeset) do
      {:ok, _object} ->
        socket =
          socket
          |> put_flash(:success, "Object successfully created")
          |> assign_form(build_changeset())

        {:noreply, socket}

      {:error, changeset} ->
        socket =
          socket
          |> put_flash(:error, inspect(changeset.errors))

        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, changeset) do
    assign(socket, form: to_form(changeset, as: :object))
  end

    defp build_changeset(params \\ %{}) do
    data = %{}

    types = %{
      text: :string,
      select: :string,
      checkbox_group: {:array, :string},
      radio_group: :string,
      textarea: :string,
      checkbox: :boolean,
      color: :string,
      date: :date,
      datetime: :naive_datetime,
      email: :string,
      file: :string,
      hidden: :string,
      month: :string,
      number: :integer,
      password: :string,
      radio: :string,
      range: :integer,
      search: :string,
      tel: :string,
      time: :time,
      url: :string,
      week: :string,
      switch: :boolean
    }

    {data, types}
    |> Ecto.Changeset.cast(params, Map.keys(types))
    |> Ecto.Changeset.validate_required([:text])
    |> Ecto.Changeset.validate_acceptance(:checkbox)
    |> Ecto.Changeset.validate_length(:text, min: 3, max: 50)
  end

  defp validate_changeset(changeset) do
    Ecto.Changeset.apply_action(changeset, :validate)
  end


  @impl true
  def handle_params(params, _uri, socket) do
    case socket.assigns.live_action do
      :index ->
        {:noreply, assign(socket, modal: false, slide_over: false)}

      :modal ->
        {:noreply, assign(socket, modal: params["size"])}

      :slide_over ->
        {:noreply, assign(socket, slide_over: params["origin"])}

      :pagination ->
        {:noreply, assign(socket, pagination_page: String.to_integer(params["page"]))}
    end
  end

  @impl true
  def render(assigns) do
    ~H"""

<!DOCTYPE html>
<html lang="en">
<head>
    <title>SwiftBOM - SBOM Generator</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="/assets/jquery-3.6.0.min.js"></script>
</head>
<body class="bg-gray-100 p-4">
    <div class="w-full h-screen flex">
        <!-- Column 1: Organization Info (20%) -->
        <div class="w-1/5 bg-white shadow-md p-4 border-r border-gray-300">
            <h2 class="text-lg font-semibold mb-2">Organization Info</h2>
            <div class="mb-4">
                <span class="block text-gray-600">Document Name</span>
                <p class="text-gray-800">ACME-INFUSION-1.0-SBOM-DRAFT</p>
            </div>
            <button class="bg-blue-500 text-white py-1 px-3 rounded" onclick="$('#orgForm').toggle()">Edit</button>
            <button class="bg-green-500 text-white py-1 px-3 rounded ml-2" onclick="addOrg()">+</button>
            <form id="orgForm" class="mt-4 hidden">
                <input type="text" id="orgName" class="w-full border rounded p-2 mb-2" placeholder="Document Name">
            </form>
            <ul id="orgList" class="mt-2 text-gray-800"></ul>
        </div>

        <!-- Column 2: Primary Component (20%) -->
        <div class="w-1/5 bg-white shadow-md p-4 border-r border-gray-300">
            <h2 class="text-lg font-semibold mb-2">Application</h2>
            <div class="mb-4">
                <span class="block text-gray-600">Primary Component</span>
                <p class="text-gray-800">Application Name</p>
            </div>
            <button class="bg-blue-500 text-white py-1 px-3 rounded" onclick="$('#appForm').toggle()">Edit</button>
            <button class="bg-green-500 text-white py-1 px-3 rounded ml-2" onclick="addApp()">+</button>
            <form id="appForm" class="mt-4 hidden">
                <input type="text" id="appName" class="w-full border rounded p-2 mb-2" placeholder="Component Name">
            </form>
            <ul id="appList" class="mt-2 text-gray-800"></ul>
        </div>

        <!-- Column 3: Components Table (60%) -->
        <div class="w-3/5 bg-white shadow-md p-4">
            <h2 class="text-lg font-semibold mb-2">Components</h2>
             <.button label="+" link_type="live_patch" to={~p"/sbomcomponent/right"} />

           <!--  <button class="bg-green-500 text-white py-1 px-3 rounded mb-2" onclick="addComponent()">+</button> -->
            <table class="w-full border">
                <thead>
                    <tr class="bg-gray-200">
                        <th class="border p-2">Component Name</th>
                        <th class="border p-2">Version</th>
                        <th class="border p-2">Action</th>
                    </tr>
                </thead>
                <tbody id="componentTable">
                    <tr>
                        <td class="border p-2">Example Component</td>
                        <td class="border p-2">1.0</td>
                        <td class="border p-2">
                        <button class="bg-red-500 text-white py-1 px-3 rounded" onclick="$(this).closest('tr').remove()">Delete</button>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
     <%= if @slide_over do %>
        <.slide_over origin={@slide_over} title="SlideOver">
          <div class="gap-5 text-sm  max-h-screen overflow-y-auto" >
  <.form for={@form} phx-submit="submit" phx-change="validate">
    
    <!-- Child BOM Exists Checkbox -->
    <.field type="checkbox" label="Child BOM exists" field={@form[:childbom]} phx-click="toggle_childbom" />
    
    <!-- Conditionally shown Child BOM SPDX File Input -->
    <%= if @show_childbom_spdx do %>
      <.field type="file" label="Child BOM SPDX" field={@form[:child_bom_spdx]} />
    <% end %>
    
    <!-- Component Name -->
    <.field label="Component Name" field={@form[:component_name]} />
    
    <!-- Version -->
    <.field label="Version" field={@form[:version]} />
    

    <!-- Supplier Name: Dropdown + Text Input -->
    <.field field={@form[:supplier]} label="Supplier Name">
      <div class="flex gap-2">
        <.field
  field={@form[:supplier_type]}
  type="select"
  options={[{"Organization", "organization"}, {"Person", "person"}, {"Tools", "tools"}]}
  help_text="Select Suppliers type"
/>
    <.field field={@form[:supplier_name]}>
        <.input placeholder="Enter name" />
    </.field>
      </div>
    </.field>

    <.field field={@form[:supplier_type]} type="select" options={[{"Organization", "organization"}, {"Person", "person"}, {"Tools", "tools"}]} help_text="Select Suppliers type" />


    
    <!-- Relationship Dropdown -->
    <.field label="Relationship" field={@form[:relationship]} type="select" options={[{"Included","included"}, {"Primary","primary"}]} />
    
    <!-- Component Checksum -->
    <.field field={@form[:checksum_type]} type="select" options={[{"File","File"}, {"Package","Package"}]}  phx-click="toggle_checksum_type" help_text="Select Component types" />
    
    <!-- Conditionally Shown Checksum Details (For File Type) -->
    <%= if @show_checksum_details do %>
      <.field label="Algorithm" field={@form[:checksum_algorithm]} type="select"  options={[{"SHA1","SHA1"}, {"SHA256","SHA256"},{"MD5", "MD5"}]} />
      <.field label="File Name" field={@form[:checksum_filename]} />
      <.field label="Checksum Value" field={@form[:checksum_value]} />
    <% end %>
    
    <!-- Action Buttons -->
    <div class="flex justify-end gap-3">
      <.button type="button" label="Cancel" color="white" phx-click={PetalComponents.SlideOver.hide_slide_over(@slide_over)} />
      <.button type="submit" label="Submit" />
    </div>
  </.form>

</div>

        </.slide_over>
      <% end %>

    <script>

        function addOrg() {
            let name = $("#orgName").val();
            if (name) {
                $("#orgList").append("<li>" + name + "</li>");
                $("#orgName").val('');
            }
        }

        function addApp() {
            let name = $("#appName").val();
            if (name) {
                $("#appList").append("<li>" + name + "</li>");
                $("#appName").val('');
            }
        }

        function addComponent() {
            let name = prompt("Enter Component Name:");
            let version = prompt("Enter Version:");
            if (name && version) {
                $("#componentTable").append(`
                    <tr>
                        <td class="border p-2">${name}</td>
                        <td class="border p-2">${version}</td>
                        <td class="border p-2">
                            <button class="bg-red-500 text-white py-1 px-3 rounded" onclick="$(this).closest('tr').remove()">Delete</button>
                        </td>
                    </tr>
                `);
            }
        }
    </script>
</body>
</html>

    """
  end
  @impl true
 def handle_event("close_slide_over", _, socket) do
    {:noreply, push_patch(socket, to: "/sbomcomponent")}
  end

end
