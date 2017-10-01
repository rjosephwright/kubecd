defmodule Kubecd.Concourse.Types.Build do
  @derive [Poison.Encoder]
  defstruct  [:id, :name, :status,
	      :job_name, :pipeline_name,
	      :team_name, :url, :api_url]
end

defmodule Kubecd.Concourse.Types.Pipe do
  @derive [Poison.Encoder]
  defstruct  [:id, :read_url, :write_url]
end
