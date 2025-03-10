defmodule DaProductAppWeb.UserLoginLive do
  use DaProductAppWeb, :live_view

  def render(assigns) do
    ~H"""
    <div class="min-h-screen flex items-center justify-center bg-gray-50 px-4">
      <div class="mx-auto w-full max-w-sm">
        <!-- Logo -->
        <div class="flex justify-center mb-6">
          <img src={~p"/images/logo.png"} alt="Logo" class="h-12 w-auto">
        </div>

        <div class="bg-white shadow sm:rounded-lg p-6">
          <.header class="text-center mb-4">
            Log in to your account
            <:subtitle>
              Don't have an account?
              <.link navigate={~p"/users/register"} class="font-semibold text-brand hover:underline">
                Sign up
              </.link>
              now.
            </:subtitle>
          </.header>

          <.simple_form for={@form} id="login_form" action={~p"/users/log_in"} phx-update="ignore">
            <.input field={@form[:email]} type="email" label="Email" required />
            <.input field={@form[:password]} type="password" label="Password" required />

            <:actions>
              <.input field={@form[:remember_me]} type="checkbox" label="Keep me logged in" />
              <.link href={~p"/users/reset_password"} class="text-sm font-semibold text-brand hover:underline">
                Forgot your password?
              </.link>
            </:actions>
            <:actions>
              <.button phx-disable-with="Logging in..." class="w-full bg-brand text-white py-2 rounded">
                Log in <span aria-hidden="true">→</span>
              </.button>
            </:actions>
          </.simple_form>
        </div>
      </div>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    email = Phoenix.Flash.get(socket.assigns.flash, :email)
    form = to_form(%{"email" => email}, as: "user")
    {:ok, assign(socket, form: form), temporary_assigns: [form: form]}
  end
end

