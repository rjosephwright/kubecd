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

  match _ do
    send_resp(conn, 404, encode!(%{error: "Not found"}))
  end
end
