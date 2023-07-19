defmodule Metamorphic.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      MetamorphicWeb.Telemetry,
      # Start the RPC server
      {Fly.RPC, []},
      # Start the Ecto repository
      Metamorphic.Repo.Local,
      # Start the tracker after your DB.
      {Fly.Postgres.LSN.Supervisor, repo: Metamorphic.Repo.Local},
      # Start the Cloak vault.
      Metamorphic.Vault,
      # Start the PubSub system
      {Phoenix.PubSub, name: Metamorphic.PubSub},
      # Start Finch
      {Finch, name: Metamorphic.Finch},
      # Start the Endpoint (http/https)
      MetamorphicWeb.Endpoint
      # Start a worker by calling: Metamorphic.Worker.start_link(arg)
      # {Metamorphic.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Metamorphic.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    MetamorphicWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end