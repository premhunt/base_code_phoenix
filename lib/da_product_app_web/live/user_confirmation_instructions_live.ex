defmodule DaProductAppWeb.UserConfirmationInstructionsLive do
  use DaProductAppWeb, :live_view

  import Phoenix.Component   # Import Phoenix.Component for helpers like <.simple_form>, <.input>, etc.
  alias DaProductApp.Users
  alias DaProductAppWeb.Router.Helpers, as: Routes  # Import the Routes helper module for path generation

  def render(assigns) do
    ~H"""
    <div class="mx-auto max-w-sm">
      <.header class="text-center">
        No confirmation instructions received?
        <:subtitle>We'll send a new confirmation link to your inbox</:subtitle>
      </.header>

      <.simple_form for={@form} id="resend_confirmation_form" phx-submit="send_instructions">
        <.input field={@form[:email]} type="email" placeholder="Email" required />
        <:actions>
          <.button phx-disable-with="Sending..." class="w-full">
            Resend confirmation instructions
          </.button>
        </:actions>
      </.simple_form>

      <p class="text-center mt-4">
        <.link href={Routes.user_registration_path(@conn, :new)}>Register</.link>
        | <.link href={Routes.user_session_path(@conn, :new)}>Log in</.link>
      </p>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, assign(socket, form: to_form(%{}, as: "user"))}
  end

  def handle_event("send_instructions", %{"user" => %{"email" => email}}, socket) do
    if user = Users.get_user_by_email(email) do
      Users.deliver_user_confirmation_instructions(
        user,
        &Routes.user_confirmation_url(@conn, :edit, &1)   # Use the correct route helper for generating the confirmation URL
      )
    end

    info =
      "If your email is in our system and it has not been confirmed yet, you will receive an email with instructions shortly."

    {:noreply,
     socket
     |> put_flash(:info, info)
     |> redirect(to: Routes.page_path(@conn, :index))}  # Use the correct route helper for the redirect
  end
end

