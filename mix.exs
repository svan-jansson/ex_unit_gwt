defmodule ExUnitGWT.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_unit_gwt,
      version: "1.0.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      docs: docs(),
      name: "ExUnitGWT",
      source_url: "https://github.com/svan-jansson/ex_unit_gwt"
    ]
  end

  def application do
    [
      env: [
        formatters: [ExUnitGWT.CLIFormatter]
      ]
    ]
  end

  defp deps do
    [{:ex_doc, "~> 0.19", only: :dev, runtime: false}]
  end

  defp package do
    [
      description: "Given-When-Then syntax for ExUnit",
      files: ["lib", "mix.exs", "README.md", ".formatter.exs"],
      maintainers: [
        "Erik Svensson"
      ],
      licenses: ["MIT"],
      links: %{
        Website: "https://github.com/svan-jansson/ex_unit_gwt",
        GitHub: "https://github.com/svan-jansson/ex_unit_gwt"
      }
    ]
  end

  defp docs do
    [
      main: "ExUnitGWT"
    ]
  end
end
