defmodule SuperSimpleFeatureFlags.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      SuperSimpleFeatureFlagsWeb.Telemetry,
      SuperSimpleFeatureFlags.Repo,
      {DNSCluster, query: Application.get_env(:super_simple_feature_flags, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: SuperSimpleFeatureFlags.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: SuperSimpleFeatureFlags.Finch},
      # Start a worker by calling: SuperSimpleFeatureFlags.Worker.start_link(arg)
      # {SuperSimpleFeatureFlags.Worker, arg},
      # Start to serve requests, typically the last entry
      SuperSimpleFeatureFlagsWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SuperSimpleFeatureFlags.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    SuperSimpleFeatureFlagsWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
