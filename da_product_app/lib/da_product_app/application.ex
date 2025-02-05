defmodule DaProductApp.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      DaProductAppWeb.Telemetry,
      DaProductApp.Repo,
      {DNSCluster, query: Application.get_env(:da_product_app, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: DaProductApp.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: DaProductApp.Finch},
      # Start a worker by calling: DaProductApp.Worker.start_link(arg)
      # {DaProductApp.Worker, arg},
      # Start to serve requests, typically the last entry
      DaProductAppWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: DaProductApp.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    DaProductAppWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
