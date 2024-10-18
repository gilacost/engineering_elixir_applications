# in lib/kanban/prom_ex/cpu_plugin.ex

defmodule Kanban.PromEx.CpuPlugin do
  use PromEx.Plugin

  alias Kanban.AwsRepo

  require Logger

  @cpu_event [:prom_ex, :plugin, :os, :cpu]

  defp cpu_metrics(poll_rate) do
    Polling.build(
      :os_cpu_polling_events,
      poll_rate,
      {__MODULE__, :execute_cpu_metrics, []},
      [
        last_value(
          [:cpu, :util],
          event_name: @cpu_event,
          description: "The total CPU usage of the host system in seconds",
          measurement: :util,
          unit: :second,
          tags: [:instance_id]
        )
      ]
    )
  end

  @doc false
  def execute_cpu_metrics do
    with {:ok, instance_id} <- AwsRepo.get_self_instance_id(),
         {:ok, cpu_average} <- AwsRepo.get_cpu_average(instance_id) do
      :telemetry.execute(
        @cpu_event,
        %{util: cpu_average},
        %{instance_id: instance_id}
      )
    else
      {:error, error} ->
        Logger.error("Error getting cpu usage: #{inspect(error)}")

        :telemetry.execute(@cpu_event, %{util: 0.0}, %{})
    end
  end


  @impl true
  def polling_metrics(opts) do
    poll_rate = Keyword.get(opts, :poll_rate, 1_000)

    [
      cpu_metrics(poll_rate)
    ]
  end

end

