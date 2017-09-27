defmodule Kubecd.Web.Router do
  import Poison, only: [encode!: 1]
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

  get "/api/v1/info" do
    send_resp(conn, 200, encode!(%{version: "3.3.2"}))
  end

  post "/api/v1/builds" do
    maps = conn.body_params["do"]
    [task | _] = Enum.filter maps, fn map -> "task" in Map.keys map; end
    job = Kubecd.Task.concourse_task_to_k8s_job(task["task"]["config"])
    Kubecd.Task.run_job(job, "ci")
    send_resp(conn, 400, encode!(%{message: "api"}))
  end

  post "/api/v1/pipes" do
    send_resp(conn, 200, encode!(%{message: "api"}))
  end

  match _ do
    send_resp(conn, 404, encode!(%{error: "Not found"}))
  end
end
