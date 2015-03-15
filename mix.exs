defmodule Librex.Mixfile do
  use Mix.Project

  def project do
    [app: :librex,
     version: "0.1.0",
     elixir: "~> 1.0",
     description: description
     deps: deps]
  end

  def application do
    [applications: [:logger]]
  end

  defp deps do
    [{:secure_random, "~> 0.1"}]
  end

  defp description
    "Convert office documents to other formats using LibreOffice"
  end

  defp package do
    files: ["lib", "mix.exs", "README*", "LICENSE*"],
    contributors: ["Richard Nyström"],
    licenses: ["MIT"],
    links: %{"GitHub" => "https://github.com/ricn/librex",
           "Docs" => "https://github.com/ricn/librex"}]
  end
end
