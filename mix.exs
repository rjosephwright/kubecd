defmodule Kubecd.Mixfile do
  use Mix.Project

  def project do
    [
      app: :kubecd,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps(),
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {Kubecd, []},
    ]
  end

  defp deps do
    [
      {:cowboy, "~> 1.1"},
      {:distillery, "~> 1.4", runtime: false},
      {:plug, "~> 1.4"},
      {:poison, "~> 3.1"},
      {:httpoison, "~> 0.13"},
      {:uuid, "~> 1.1"},
    ]
  end
end
