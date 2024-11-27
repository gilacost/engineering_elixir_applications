# in lib/kanban/aws_repo/fixture_adapter.ex

defmodule Kanban.AwsRepo.FixtureAdapter do
  @behaviour Kanban.AwsRepo

  alias Kanban.AwsRepo

  @impl AwsRepo
  def get_cpu_average(_instance_id) do
    {:ok, Enum.random(1..99) + 0.123456}
  end

  @impl AwsRepo
  def get_self_instance_id do
    {:ok, "i-09ba9852c02d92e38"}
  end
end
