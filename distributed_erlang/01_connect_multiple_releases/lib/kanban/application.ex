# START: dns_cluster
# in lib/kanban/application.ex

# END: dns_cluster
defmodule Kanban.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    # START: dns_cluster
    children = [
      # END: dns_cluster
      # Start the Telemetry supervisor
      KanbanWeb.Telemetry,
      # Start the Ecto repository
      Kanban.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Kanban.PubSub},
      # Start Finch
      {Finch, name: Kanban.Finch},
      # Start the Endpoint (http/https)
      KanbanWeb.Endpoint,
      # Start a worker by calling: Kanban.Worker.start_link(arg)
      # {Kanban.Worker, arg}
      # START: dns_cluster
      {DNSCluster, query: "tasks.web"}
    ]
    # END: dns_cluster

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Kanban.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    KanbanWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
