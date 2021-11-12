use Mix.Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :dbstore, Dbstore.Repo,
  username: "postgres",
  password: "postgres",
  database: "dbstore_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
