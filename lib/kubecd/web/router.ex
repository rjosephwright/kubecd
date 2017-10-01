defmodule Kubecd.Web.Router do
  import Poison, only: [encode!: 1]
  alias Kubecd.Concourse.Types, as: T
  use Plug.Router

  plug Plug.Logger, log: :debug
  plug Plug.Parsers,
    parsers: [:json],
    pass: ["application/json"],
    json_decoder: Poison
  plug :match
  plug :dispatch

  get "/api/v1" do
    send_resp(conn, 200, encode!(%{message: "api"}))
  end

  end

  post "/api/v1/builds" do
    maps = conn.body_params["do"]
    [task | _] = Enum.filter maps, fn map -> "task" in Map.keys map; end
    job = Kubecd.Task.concourse_task_to_k8s_job(task["task"]["config"])
    Kubecd.Task.run_job(job, "ci")
    build = %T.Build{
      id: 1,
      name: "myName",
      status: "myStatus",
      job_name: "myJobName",
      pipeline_name: "myPipeline",
      team_name: "myTeam",
      url: "/api/v1/builds/1",
      api_url: "myApiUrl"
    }
    send_resp(conn, 200, encode!(build))
  end

  post "/api/v1/pipes" do
    id = UUID.uuid4
    url = System.get_env("EXTERNAL_URL")
    pipe = %T.Pipe{
      id: id,
      read_url: "#{url}/api/v1/pipes/#{id}",
      write_url: "#{url}/api/v1/pipes/#{id}",
    }
    send_resp(conn, 201, encode!(pipe))
  end

  # WritePipe
  put "/api/v1/pipes/:pipe_id" do
    send_resp(conn, 200, encode!(%{}))
  end

  # ReadPipe
  get "/api/v1/pipes/:pipe_id" do
    send_resp(conn, 200, encode!(%{}))
  end

  match _ do
    send_resp(conn, 404, encode!(%{error: "Not found"}))
  end
end
