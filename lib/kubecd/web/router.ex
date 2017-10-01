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

  # SaveConfig
  put "/api/v1/teams/:team_name/pipelines/:pipeline_name/config" do
    send_resp(conn, 200, encode!(%{}))
  end

  # GetConfig
  get "/api/v1/teams/:team_name/pipelines/:pipeline_name/config" do
    send_resp(conn, 200, encode!(%{}))
  end

  # CreateBuild
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

  # ListBuilds
  get "/api/v1/builds" do
    send_resp(conn, 200, encode!(%{}))
  end

  # GetBuild
  get "/api/v1/builds/:build_id" do
    send_resp(conn, 200, encode!(%{}))
  end

  # GetBuildPlan
  get "/api/v1/builds/:build_id/plan" do
    send_resp(conn, 200, encode!(%{}))
  end

  # BuildEvents
  get "/api/v1/builds/:build_id/events" do
    send_resp(conn, 200, encode!(%{}))
  end

  # BuildResources
  get "/api/v1/builds/:build_id/resources" do
    send_resp(conn, 200, encode!(%{}))
  end

  # AbortBuild
  put "/api/v1/builds/:build_id/abort" do
    send_resp(conn, 200, encode!(%{}))
  end

  # GetBuildPreparation
  get "/api/v1/builds/:build_id/preparation" do
    send_resp(conn, 200, encode!(%{}))
  end

  # ListJobs
  get "/api/v1/teams/:team_name/pipelines/:pipeline_name/jobs" do
    send_resp(conn, 200, encode!(%{}))
  end

  # GetJob
  get "/api/v1/teams/:team_name/pipelines/:pipeline_name/jobs/:job_name" do
    send_resp(conn, 200, encode!(%{}))
  end

  # ListJobBuilds
  get "/api/v1/teams/:team_name/pipelines/:pipeline_name/jobs/:job_name/builds" do
    send_resp(conn, 200, encode!(%{}))
  end

  # CreateJobBuild
  post "/api/v1/teams/:team_name/pipelines/:pipeline_name/jobs/:job_name/builds" do
    send_resp(conn, 200, encode!(%{}))
  end

  # ListJobInputs
  get "/api/v1/teams/:team_name/pipelines/:pipeline_name/jobs/:job_name/inputs" do
    send_resp(conn, 200, encode!(%{}))
  end

  # GetJobBuild
  get  "/api/v1/teams/:team_name/pipelines/:pipeline_name/jobs/:job_name/builds/:build_name" do
    send_resp(conn, 200, encode!(%{}))
  end

  # PauseJob
  put "/api/v1/teams/:team_name/pipelines/:pipeline_name/jobs/:job_name/pause" do
    send_resp(conn, 200, encode!(%{}))
  end

  # UnpauseJob
  put "/api/v1/teams/:team_name/pipelines/:pipeline_name/jobs/:job_name/unpause" do
    send_resp(conn, 200, encode!(%{}))
  end

  # JobBadge
  get "/api/v1/teams/:team_name/pipelines/:pipeline_name/jobs/:job_name/badge" do
    send_resp(conn, 200, encode!(%{}))
  end

  # MainJobBadge
  get "/api/v1/pipelines/:pipeline_name/jobs/:job_name/badge" do
    send_resp(conn, 200, encode!(%{}))
  end

  # ListAllPipelines
  get "/api/v1/pipelines" do
    send_resp(conn, 200, encode!(%{}))
  end

  # ListPipelines
  get "/api/v1/teams/:team_name/pipelines" do
    send_resp(conn, 200, encode!(%{}))
  end

  # GetPipeline
  get "/api/v1/teams/:team_name/pipelines/:pipeline_name" do
    send_resp(conn, 200, encode!(%{}))
  end

  # DeletePipeline
  delete "/api/v1/teams/:team_name/pipelines/:pipeline_name" do
    send_resp(conn, 200, encode!(%{}))
  end

  # OrderPipelines
  put "/api/v1/teams/:team_name/pipelines/ordering" do
    send_resp(conn, 200, encode!(%{}))
  end

  # PausePipeline
  put "/api/v1/teams/:team_name/pipelines/:pipeline_name/pause" do
    send_resp(conn, 200, encode!(%{}))
  end

  # UnpausePipeline
  put "/api/v1/teams/:team_name/pipelines/:pipeline_name/unpause" do
    send_resp(conn, 200, encode!(%{}))
  end

  # ExposePipeline
  put "/api/v1/teams/:team_name/pipelines/:pipeline_name/expose" do
    send_resp(conn, 200, encode!(%{}))
  end

  # HidePipeline
  put "/api/v1/teams/:team_name/pipelines/:pipeline_name/hide" do
    send_resp(conn, 200, encode!(%{}))
  end

  # GetVersionsDB
  get "/api/v1/teams/:team_name/pipelines/:pipeline_name/versions-db" do
    send_resp(conn, 200, encode!(%{}))
  end

  # RenamePipeline
  put "/api/v1/teams/:team_name/pipelines/:pipeline_name/rename" do
    send_resp(conn, 200, encode!(%{}))
  end

  # CreatePipelineBuild
  post "/api/v1/teams/:team_name/pipelines/:pipeline_name/builds" do
    send_resp(conn, 200, encode!(%{}))
  end

  # ListResources
  get "/api/v1/teams/:team_name/pipelines/:pipeline_name/resources" do
    send_resp(conn, 200, encode!(%{}))
  end

  # GetResource
  get "/api/v1/teams/:team_name/pipelines/:pipeline_name/resources/:resource_name" do
    send_resp(conn, 200, encode!(%{}))
  end

  # PauseResource
  put "/api/v1/teams/:team_name/pipelines/:pipeline_name/resources/:resource_name/pause" do
    send_resp(conn, 200, encode!(%{}))
  end

  # UnpauseResource
  put "/api/v1/teams/:team_name/pipelines/:pipeline_name/resources/:resource_name/unpause" do
    send_resp(conn, 200, encode!(%{}))
  end

  # CheckResource
  post "/api/v1/teams/:team_name/pipelines/:pipeline_name/resources/:resource_name/check" do
    send_resp(conn, 200, encode!(%{}))
  end

  # CheckResourceWebHook
  post "/api/v1/teams/:team_name/pipelines/:pipeline_name/resources/:resource_name/check/webhook" do
    send_resp(conn, 200, encode!(%{}))
  end

  # ListResourceVersions
  get "/api/v1/teams/:team_name/pipelines/:pipeline_name/resources/:resource_name/versions" do
    send_resp(conn, 200, encode!(%{}))
  end

  # EnableResourceVersion
  put "/api/v1/teams/:team_name/pipelines/:pipeline_name/resources/:resource_name/versions/:resource_version_id/enable" do
    send_resp(conn, 200, encode!(%{}))
  end

  # DisableResourceVersion
  put "/api/v1/teams/:team_name/pipelines/:pipeline_name/resources/:resource_name/versions/:resource_version_id/disable" do
    send_resp(conn, 200, encode!(%{}))
  end

  # ListBuildsWithVersionAsInput
  get "/api/v1/teams/:team_name/pipelines/:pipeline_name/resources/:resource_name/versions/:resource_version_id/input_to" do
    send_resp(conn, 200, encode!(%{}))
  end

  # ListBuildsWithVersionAsOutput
  get "/api/v1/teams/:team_name/pipelines/:pipeline_name/resources/:resource_name/versions/:resource_version_id/output_of" do
    send_resp(conn, 200, encode!(%{}))
  end

  # CreatePipe
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

  # ListWorkers
  get "/api/v1/workers" do
    send_resp(conn, 200, encode!(%{}))
  end

  # RegisterWorker
  post "/api/v1/workers" do
    send_resp(conn, 200, encode!(%{}))
  end

  # LandWorker
  put "/api/v1/workers/:worker_name/land" do
    send_resp(conn, 200, encode!(%{}))
  end

  # RetireWorker
  put "/api/v1/workers/:worker_name/retire" do
    send_resp(conn, 200, encode!(%{}))
  end

  # PruneWorker
  put "/api/v1/workers/:worker_name/prune" do
    send_resp(conn, 200, encode!(%{}))
  end

  # HeartbeatWorker
  put "/api/v1/workers/:worker_name/heartbeat" do
    send_resp(conn, 200, encode!(%{}))
  end

  # DeleteWorker
  delete "/api/v1/workers/:worker_name" do
    send_resp(conn, 200, encode!(%{}))
  end

  # GetLogLevel
  get "/api/v1/log-level" do
    send_resp(conn, 200, encode!(%{}))
  end

  # SetLogLevel
  put "/api/v1/log-level" do
    send_resp(conn, 200, encode!(%{}))
  end

  # DownloadCLI
  get "/api/v1/cli" do
    send_resp(conn, 200, encode!(%{}))
  end

  # GetInfo
  get "/api/v1/info" do
    send_resp(conn, 200, encode!(%{version: "3.3.2"}))
  end

  # ListContainers
  get "/api/v1/containers" do
    send_resp(conn, 200, encode!(%{}))
  end

  # GetContainer
  get "/api/v1/containers/:id" do
    send_resp(conn, 200, encode!(%{}))
  end

  # HijackContainer
  get "/api/v1/containers/:id/hijack" do
    send_resp(conn, 200, encode!(%{}))
  end

  # ListVolumes
  get "/api/v1/volumes" do
    send_resp(conn, 200, encode!(%{}))
  end

  # ListAuthMethods
  get "/api/v1/teams/:team_name/auth/methods" do
    send_resp(conn, 200, encode!(%{}))
  end

  # GetAuthToken
  get "/api/v1/teams/:team_name/auth/token" do
    send_resp(conn, 200, encode!(%{}))
  end

  # GetUser
  get "/api/v1/user" do
    send_resp(conn, 200, encode!(%{}))
  end

  # ListTeams
  get "/api/v1/teams" do
    send_resp(conn, 200, encode!(%{}))
  end

  # SetTeam
  put "/api/v1/teams/:team_name" do
    send_resp(conn, 200, encode!(%{}))
  end

  # DestroyTeam
  delete "/api/v1/teams/:team_name" do
    send_resp(conn, 200, encode!(%{}))
  end

  match _ do
    send_resp(conn, 404, encode!(%{error: "Not found"}))
  end
end
