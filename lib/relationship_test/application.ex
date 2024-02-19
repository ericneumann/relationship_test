defmodule RelationshipTest.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      RelationshipTestWeb.Telemetry,
      RelationshipTest.Repo,
      {DNSCluster, query: Application.get_env(:relationship_test, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: RelationshipTest.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: RelationshipTest.Finch},
      # Start a worker by calling: RelationshipTest.Worker.start_link(arg)
      # {RelationshipTest.Worker, arg},
      # Start to serve requests, typically the last entry
      RelationshipTestWeb.Endpoint,
      {AshAuthentication.Supervisor, otp_app: :icq}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: RelationshipTest.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    RelationshipTestWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
