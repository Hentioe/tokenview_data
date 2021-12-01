defmodule TokenviewData.MixProject do
  use Mix.Project

  @version "0.1.0-rc.1"

  def project do
    [
      app: :tokenview_data,
      version: @version,
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {TokenviewData.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:dialyxir, "~> 1.1", only: [:dev], runtime: false},
      {:credo, "~> 1.6", only: [:dev, :test], runtime: false},
      {:httpoison, "~> 1.8"},
      {:plug, "~> 1.12"},
      {:plug_cowboy, "~> 2.5"},
      {:jason, "~> 1.2"}
    ]
  end
end
