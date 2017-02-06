defmodule Librex.Mixfile do
  use Mix.Project

  def project do
    [app: :librex,
     version: "1.0.1",
     elixir: "~> 1.0",
     description: description(),
     package: package(),
     deps: deps(),
     test_coverage: [tool: ExCoveralls]]
  end

  def application do
    [applications: [:logger]]
  end

  defp deps do
    [{:secure_random, "~> 0.5"},
     {:inch_ex, "~> 0.5", only: :docs},
     {:earmark, "~> 1.1", only: :dev},
     {:ex_doc, "~> 0.14", only: :dev},
     {:excoveralls, "~> 0.6", only: [:dev, :test]}]
  end

  defp description do
    "Convert office documents to other formats using LibreOffice"
  end

  defp package do
    [files: ["lib", "mix.exs", "README*", "LICENSE*"],
     contributors: ["Richard Nyström"],
     licenses: ["MIT"],
     links: %{"GitHub" => "https://github.com/ricn/librex", "Docs" => "http://hexdocs.pm/librex"}]
  end
end
