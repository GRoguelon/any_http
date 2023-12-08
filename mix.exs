defmodule AnyHttp.MixProject do
  use Mix.Project

  def project do
    [
      app: :any_http,
      version: "0.3.2",
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
      extra_applications: [:inets, :logger, :public_key, :ssl]
    ]
  end

  defp docs do
    [
      formatters: ["html"],
      main: "readme",
      extras: ["README.md"],
      groups_for_modules: [
        Adapters: [AnyHttp.Adapters.Req, AnyHttp.Adapters.Httpc]
      ]
    ]
  end

  defp dialyzer do
    [
      plt_file: {:no_warn, "priv/plts/project.plt"},
      plt_add_apps: [:req]
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
      {:bypass, "~> 2.1", only: :test},
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.3", only: [:dev], runtime: false},
      {:ex_doc, "~> 0.29", only: :dev, runtime: false},
      # Req client
      {:req, "~> 0.3", optional: true},
      # :httpc client
      {:castore, "~> 1.0", optional: true}
    ]
  end
end
