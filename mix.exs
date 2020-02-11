defmodule DifferEcto.MixProject do
  use Mix.Project

  def project do
    [
      app: :differ_ecto,
      version: "0.1.0",
      source_url: "https://github.com/DanilaMihailov/differ_ecto",
      homepage_url: "https://github.com/DanilaMihailov/differ_ecto",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      package: package(),
      docs: docs(),
      # test coverage
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ]
    ]
  end

  def application do
    []
  end

  defp deps do
    [
      {:differ, "~> 0.1.1"},
      {:ecto_sql, "~> 3.0"},
      # generating documentation (mix docs)
      {:ex_doc, "~> 0.21", only: :dev, runtime: false},
      # test coverage (mix coveralls.html or mix test --cover)
      {:excoveralls, "~> 0.12.1", only: :test, runtime: false}
    ]
  end

  defp description() do
    "Ecto.Type for Differ (and some helpers)"
  end

  defp package() do
    [
      licenses: ["Apache-2.0"],
      links: %{"GitHub" => "https://github.com/DanilaMihailov/differ_ecto"}
    ]
  end

  defp docs do
    [
      main: "readme",
      extras: [
        "README.md"
      ]
    ]
  end
end
