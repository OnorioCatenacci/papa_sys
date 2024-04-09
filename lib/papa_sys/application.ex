defmodule PapaSys.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      PapaSysWeb.Telemetry,
      PapaSys.Repo,
      {Ecto.Migrator,
        repos: Application.fetch_env!(:papa_sys, :ecto_repos),
        skip: skip_migrations?()},
      {DNSCluster, query: Application.get_env(:papa_sys, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: PapaSys.PubSub},
      # Start a worker by calling: PapaSys.Worker.start_link(arg)
      # {PapaSys.Worker, arg},
      # Start to serve requests, typically the last entry
      PapaSysWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PapaSys.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PapaSysWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  defp skip_migrations?() do
    # By default, sqlite migrations are run when using a release
    System.get_env("RELEASE_NAME") != nil
  end
end
