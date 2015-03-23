defmodule Librex.Mixfile do
  use Mix.Project

  def project do
    [app: :librex,
     version: "0.9.1",
     elixir: "~> 1.0",
     description: description,
     package: package,
     deps: deps]
  end

  def application do
    [applications: [:logger]]
  end

  defp deps do
    [{:secure_random, "~> 0.1"},
     {:inch_ex, only: :docs},
     {:earmark, "~> 0.1", only: :dev},
     {:ex_doc, "~> 0.7", only: :dev}]
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
