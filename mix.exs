defmodule Apify.MixProject do
  use Mix.Project

  @version "0.0.0"
  @source_url "https://github.com/chazwatkins/apify"

  def project do
    [
      app: :apify,
      version: @version,
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      consolidate_protocols: Mix.env() != :dev,
      name: "Apify API Client",
      source_url: @source_url,
      homepage_url: @source_url,
      deps: deps(),
      docs: docs(),
      package: package()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    if Mix.env() == :prod do
      [
        extra_applications: [:logger]
      ]
    else
      [
        extra_applications: [:logger]
      ]
    end
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # HTTP client
      {:req, "~> 0.5", optional: true},

      # JSON serialization
      {:jason, "~> 1.4", optional: true},

      # Telemetry for instrumentation
      {:telemetry, "~> 1.0"},

      # For webhook signature verification
      {:plug_crypto, "~> 1.2", optional: true},

      # Documentation
      {:ex_doc, "~> 0.29", only: :dev, runtime: false},

      # Development tools
      {:igniter, "~> 0.5", only: [:dev, :test]},
      {:oapi_generator, github: "chazwatkins/open-api-generator", only: :dev, runtime: false}
    ]
  end

  defp docs do
    [
      main: "readme",
      extras: [
        "README.md": [title: "Overview"]
      ],
      groups_for_modules: [
        Client: [
          Apify,
          Apify.Client,
          Apify.Config,
          Apify.Error,
          Apify.Operation,
          Apify.Webhook,
          Apify.Encoder
        ],
        Testing: [
          Apify.Testing,
          Apify.Plugin.TestClient
        ],
        Plugins: ~r/Apify.Plugin/,
        Operations: [
          # These will be filled in by the generator
        ],
        Schemas: ~r//
      ]
    ]
  end

  defp package do
    [
      description: "Apify API Client for Elixir",
      files: [
        ".api-version",
        ".formatter.exs",
        "lib",
        "LICENSE",
        "mix.exs",
        "README.md"
      ],
      licenses: ["MIT"],
      links: %{"GitHub" => @source_url},
      maintainers: ["Chaz Watkins"]
    ]
  end
end
