# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :da_product_app, DaProductApp.Repo,
  migration_primary_key: [name: :id, type: :binary_id]

config :da_product_app, :env, Mix.env()

config :da_product_app,
  ecto_repos: [DaProductApp.Repo],
  generators: [timestamp_type: :utc_datetime, binary_id: true]

# Configures the endpoint
config :da_product_app, DaProductAppWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [html: DaProductAppWeb.ErrorHTML, json: DaProductAppWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: DaProductApp.PubSub,
  live_view: [signing_salt: "Rs4sgrNR"]

#config :oban,
#  name: Oban,
#  repo: DaProductApp.Repo,
#  engine: Oban.Engines.Basic,   # Use Basic Engine instead of Postgres
#  queues: [default: 10],        # Define your queues
#  notifier: Oban.Notifiers.Null, # Disable PostgreSQL-based notifier
#  peer: false        
# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :da_product_app, DaProductApp.Mailer, adapter: Swoosh.Adapters.Local

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.17.11",
  da_product_app: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configure tailwind (the version is required)
config :tailwind,
  version: "3.4.3",
  da_product_app: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/app.css
      --output=../priv/static/assets/app.css
    ),
    cd: Path.expand("../assets", __DIR__)
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :da_product_app, Oban,
  repo: DaProductApp.Repo,
  queues: [default: 10, mailers: 20, high: 50, low: 5],
  plugins: [
    {Oban.Plugins.Pruner, max_age: (3600 * 24)},
    {Oban.Plugins.Cron,
      crontab: [
       # {"0 2 * * *", DaProductApp.Workers.DailyDigestWorker},
       # {"@reboot", DaProductApp.Workers.StripeSyncWorker},
       # {"0 2 * * *", DaProductApp.DailyReports.DailyReportWorker},
     ]}
  ]


# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
