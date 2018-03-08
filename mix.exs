defmodule Stix.Mixfile do
  use Mix.Project

  def project do
    [
      app: :stix,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:uuid, "~> 1.1"},
      {:poison, "~> 3.1"},
      {:timex, "~> 3.1"}
    ]
  end
end
