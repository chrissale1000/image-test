defmodule ImageTest.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ImageTestWeb.Telemetry,
      ImageTest.Repo,
      {DNSCluster, query: Application.get_env(:image_test, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: ImageTest.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: ImageTest.Finch},
      # Start a worker by calling: ImageTest.Worker.start_link(arg)
      # {ImageTest.Worker, arg},
      # Start to serve requests, typically the last entry
      ImageTestWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ImageTest.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ImageTestWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
