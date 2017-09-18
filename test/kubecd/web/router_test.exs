defmodule Kubecd.Web.RouterTest do
  import Poison, only: [encode!: 1]
  use ExUnit.Case, async: true
  use Plug.Test

  @opts Kubecd.Web.Router.init([])

  test "returns the api" do
    response =  Kubecd.Web.Router.call(conn(:get, "/api/v1"), @opts)
    assert response.state == :sent
    assert response.status == 200
    assert response.resp_body == encode!(%{message: "api"})
  end
end
