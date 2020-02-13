defmodule DifferEcto.MixProject do
  use Mix.Project

  def project do
    [
      app: :differ_ecto,
      version: "0.1.0-alpha.1",
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
      {:ecto, "~> 3.3"},

      # :dev deps below

      # generating documentation (mix docs)
      {:ex_doc, "~> 0.21", only: :dev, runtime: false},
      # test coverage (mix coveralls.html or mix test --cover)
      {:excoveralls, "~> 0.12.1", only: :test, runtime: false},
      # documentation check (mix inch)
      {:inch_ex, github: "rrrene/inch_ex", only: :docs, runtime: false},
      # static analysis (mix dialyzer)
      {:dialyxir, "~> 1.0.0-rc.7", only: [:dev], runtime: false},
      # static analysis and style checks (mix credo --strict)
      {:credo, "~> 1.2", only: [:dev, :test], runtime: false},
      # mix docs.build
      {:docs_getter, "~> 0.1-pre", only: :dev, runtime: false}
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
        "README.md": [title: "README"]
      ]
    ]
  end
end
