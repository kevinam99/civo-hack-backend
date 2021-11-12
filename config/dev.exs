use Mix.Config

# Configure your database
config :dbstore, Dbstore.Repo,
  username: "postgres",
  password: "postgres",
  database: "dbstore_dev",
  hostname: "localhost",
  show_sensitive_data_on_connection_error: true,
  pool_size: 10
