use Mix.Config

# Configure your database
config :dbstore, Dbstore.Repo,
adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "dbstore_dev",
  hostname: "localhost",
  show_sensitive_data_on_connection_error: true,
  pool_size: 10


# import Config


config :api, ApiWeb.Endpoint,
  http: [port: 4000],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: []

# Set a higher stacktrace during development. Avoid configuring such
# in production as building large stacktraces may be expensive.
config :phoenix, :stacktrace_depth, 20

# Initialize plugs at runtime for faster development compilation
config :phoenix, :plug_init_mode, :runtime
config :logger, :console, format: "[$level] $message\n"
