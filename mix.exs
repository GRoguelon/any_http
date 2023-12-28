defmodule AnyHttp.MixProject do
  use Mix.Project

  def project do
    [
      app: :any_http,
      version: "0.6.0",
      elixir: "~> 1.13",
      elixirc_paths: elixirc_paths(Mix.env()),
      elixirc_options: [debug_info: Mix.env() == :dev],
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      name: "Any HTTP",
      description: "Elixir library to wrap the main HTTP libraries",
      source_url: "https://github.com/GRoguelon/any_http",
      docs: docs(),
      dialyzer: dialyzer()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:inets, :logger, :ssl]
    ]
  end

  defp docs do
    [
      formatters: ["html"],
      main: "readme",
      extras: ["README.md", "CHANGELOG.md"],
      groups_for_modules: [
        Adapters: [AnyHttp.Adapters.Httpc, AnyHttp.Adapters.Req, AnyHttp.Adapters.Hackney]
      ]
    ]
  end

  defp dialyzer do
    [
      plt_add_apps: [:req, :hackney]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp package do
    [
      # These are the default files included in the package
      files: ~w[lib mix.exs README* LICENSE*],
      licenses: ["MIT"],
      links: %{
        "Github" => "https://github.com/GRoguelon/any_http"
      }
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:tls_certificate_check, "~> 1.21"},
      # Req client
      {:req, "~> 0.3", optional: true},
      # Hackney client
      {:hackney, "~> 1.20", optional: true},

      ## Dev dependencies
      {:dialyxir, "~> 1.3", only: :dev, runtime: false},
      {:ex_doc, "~> 0.29", only: :dev, runtime: false},

      ## Test dependencies
      {:bypass, "~> 2.1", only: :test},

      ## Dev & Test dependencies
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false}
    ]
  end
end
