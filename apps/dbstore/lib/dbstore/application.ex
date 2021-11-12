defmodule Dbstore.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Dbstore.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Dbstore.PubSub}
      # Start a worker by calling: Dbstore.Worker.start_link(arg)
      # {Dbstore.Worker, arg}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: Dbstore.Supervisor)
  end
end
