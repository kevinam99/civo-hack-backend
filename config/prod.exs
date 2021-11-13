import Config

# config :dbstore, Dbstore.Repo, pool_size: 10

# config :dbstore, ecto_repos: [Dbstore.Repo]

config :dbstore, Dbstore.Repo,
adapter: Ecto.Adapters.Postgres,
  database: System.fetch_env!("DB_NAME"),
  url: System.get_env("DATABASE_URL"),
  # username: System.fetch_env!("DB_USERNAME"),
  # password: System.fetch_env!("DB_PASSWORD"),
  # hostname: System.fetch_env!("DB_HOSTNAME"),
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10"),
  ssl: true

config :api, ApiWeb.Endpoint,
http: [port: {:system, "PORT"}],
  url: [scheme: "https", host: "https://shielded-taiga-07974.herokuapp.com/api", port: 443],
  force_ssl: [rewrite_on: [:x_forwarded_proto]],
  secret_key_base: System.get_env("SECRET_KEY_BASE")



# Do not print debug messages in production
config :logger, level: :info

# import_config "prod.secret.exs"
