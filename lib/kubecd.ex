defmodule Kubecd do
  use Application

  def start(_type, _args) do
    children = [
      Plug.Adapters.Cowboy.child_spec(:http, Kubecd.Web.Router, [], port: 4001),
    ]
    opts = [strategy: :one_for_one, name: Kubecd.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
