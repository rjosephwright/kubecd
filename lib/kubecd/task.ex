defmodule Kubecd.Task do
  alias Kubecd.Kubernetes, as: K8s

  @std_headers [{"Content-Type", "application/json"}]

  def k8s_job(name, image, command, args, env) do
    %{"kind" => "Job",
      "apiVersion" => "batch/v1",
      "metadata" => %{"name" => name},
      "spec" => %{
        "completions" => 1,
        "template" => %{
          "metadata" => %{"labels" => %{"app" => name},
                          "name" => name},
          "spec" => %{
            "containers" => [%{"image" => image,
                               "name" => name,
                               "command" => [command],
                               "args" => args,
                               "env" => env}],
            "restartPolicy" => "Never"}}}}
  end

  def concourse_task_to_k8s_job(task) do
    repo = task["image_resource"]["source"]["repository"]
    tag = task["image_resource"]["source"]["tag"]
    image = "#{repo}:#{tag}"
    command = task["run"]["path"]
    args = task["run"]["args"]
    params = Map.get(task, "params", [])
    env = Enum.map(params, fn {n, v} -> %{"name" => n, "value" => v}; end)
    k8s_job(UUID.uuid4, image, command, args, env)
  end

  def run_job(job, namespace) do
    jobs_uri = "/apis/batch/v1/namespaces/#{namespace}/jobs"
    with {:ok, body} <- Poison.encode(job) do
      K8s.post(jobs_uri, body, @std_headers)
    end
  end
end
