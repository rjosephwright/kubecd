defmodule Kubecd.Kubernetes do
  use HTTPoison.Base

  @secrets "/var/run/secrets/kubernetes.io/serviceaccount"

  def auth_header() do
    {:ok, token} = File.read "#{@secrets}/token"
    {"Authorization", "Bearer #{token}"}
  end

  def ssl_options() do
    {:ssl, [{:cacertfile, "#{@secrets}/ca.crt"},
            {:server_name_indication, :disable}]}
  end

  def process_url(url) do
    k8s = System.get_env "KUBERNETES_SERVICE_HOST"
    URI.to_string(URI.merge("https://#{k8s}", url))
  end

  def process_request_headers(headers) do
    [auth_header() | headers]
  end

  def process_request_options(options) do
    [ssl_options() | options]
  end

  def process_response_body(body) do
    case Poison.decode body do
      {:ok, parsed} -> parsed
      {:error, _} -> body
    end
  end
end
