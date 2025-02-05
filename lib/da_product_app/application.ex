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
      DaProductAppWeb.Endpoint,
      {Cachex, name: :general_cache}, # You can add additional caches with different names

      #{Oban, oban_config()},
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

  defp oban_config do
  %{
    name: Oban, 
    repo: DaProductApp.Repo,
    engine: Oban.Engines.Basic,   # Use Basic Engine instead of Postgres
    queues: [default: 10],        # Define your queues
    notifier: Oban.Notifiers.Null, # Disable PostgreSQL-based notifier
    peer: false                    # Disable peer tracking (Postgres-only feature)
  }
end
 #defp oban_config do
 #   Application.fetch_env!(:da_product_app, Oban)
 # end
end
