# in lib/kanban/aws_repo.ex

defmodule Kanban.AwsRepo do
  @callback get_cpu_average(instance_id :: String.t()) ::
              {:ok, float()} | {:error, term()}
  @callback get_self_instance_id() :: {:ok, String.t()} | {:error, String.t()}

  @spec get_cpu_average(instance_id :: String.t()) ::
          {:ok, [non_neg_integer()]} | {:error, term()}
  def get_cpu_average(instance_id) do
    adapter().get_cpu_average(instance_id)
  end

  @spec get_self_instance_id() :: {:ok, String.t()} | {:error, String.t()}
  def get_self_instance_id do
    adapter().get_self_instance_id()
  end

  defp adapter,
    do:
      :kanban
      |> Application.fetch_env!(__MODULE__)
      |> Keyword.fetch!(:adapter)
end
