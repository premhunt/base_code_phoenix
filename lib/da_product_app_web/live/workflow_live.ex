defmodule DaProductAppWeb.WorkflowLive do
  use DaProductAppWeb, :live_view
  import Logger
  alias DaProductApp.Users

  def mount(_params, session, socket) do
    user_token = session["user_token"]
    user = user_token && Users.get_user_by_session_token(user_token)

    current_user = user || nil
    Logger.debug("Socket Assigns: #{inspect(socket.assigns)}", []) # Correct usage

    #current_user = Map.get(session, "current_user", nil)
    socket =
      socket
      |> assign(:current_user, current_user)
      |> assign(:show_sidebar, true)  # Enable sidebar for dashboard
      |> assign(:page_title, "Automation")  # Set the page title

    {:ok, socket}
  end

def handle_event("load_form", %{"node_id" => node_id, "type" => type}, socket) do
    form_html = case type do
      "source" -> "<p>Source Node - No Configuration Required</p>"
      "action" -> "<label>Action Name:</label> <input type='text' id='action-#{node_id}'>"
      "decision" -> "<label>Decision Condition:</label> <input type='text' id='decision-#{node_id}'>"
      "condition" -> "<label>Condition Rule:</label> <input type='text' id='condition-#{node_id}'>"
      _ -> "<p>Unknown Node Type</p>"
    end

    {:noreply, push_event(socket, "update_form", %{node_id: node_id, form: form_html})}
  end
  

def render(assigns) do
  ~H"""
  <div id="workflow-container" phx-hook="WorkflowBuilder">
    <div class="node source" id="node-source-1" data-type="source">Start</div>
    <div class="node action" id="node-action-1" data-type="action">Action</div>
    <div class="node decision" id="node-decision-1" data-type="decision">Decision</div>
    <div class="node condition" id="node-condition-1" data-type="condition">Condition</div>
  </div>

  <div id="form-container" class="form-box">
    <p>Select a node to configure.</p>
  </div>
  """
end

end

