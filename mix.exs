defmodule Ek.Mixfile do
  use Mix.Project

  def project do
    [app: :ek,
     version: "0.1.0",
     elixir: "~> 1.1-dev",
     escript: escript_config,
     deps: deps]
  end

  def application do
    [applications: [:logger, :mix]]
  end

  defp deps do
    []
  end

  defp escript_config do
    [main_module: Ek.CLI,
     path: "bin/ek"]
  end
end
