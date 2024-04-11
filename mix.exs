defmodule Elmkdir.MixProject do
  use Mix.Project

  def project do
    [
      app: :elmkdir,
      escript: escript_config(),
      version: "0.1.0",
      elixir: "~> 1.16",
      start_permanent: Mix.env() == :prod,
      deps: deps(),

      # Docs
      name: "Make unique name directories",
      source_url: "https://github.com/skusunoki/elmkdir",
      docs: [
        main: "elmkdir",
        extras: ["README.md"]
      ]
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
      {:tzdata, "~> 1.1"},
      {:ex_doc, "~> 0.24", only: :dev, runtime: false}
    ]
  end

  defp escript_config do
    [
      main_module: Elmkdir.CLI
    ]
  end
end
