defmodule NextSteps.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      NextStepsWeb.Telemetry,
      NextSteps.Repo,
      {DNSCluster, query: Application.get_env(:next_steps, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: NextSteps.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: NextSteps.Finch},
      # Start a worker by calling: NextSteps.Worker.start_link(arg)
      # {NextSteps.Worker, arg},
      # Start to serve requests, typically the last entry
      NextStepsWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: NextSteps.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    NextStepsWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
