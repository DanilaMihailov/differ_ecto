defmodule DifferEcto.MixProject do
  use Mix.Project

  def project do
    [
      app: :differ_ecto,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:differ, "~> 0.1.1"},
      {:ecto_sql, "~> 3.0"},
      # generating documentation (mix docs)
      {:ex_doc, "~> 0.21", only: :dev, runtime: false}
    ]
  end
end
