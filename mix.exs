defmodule LibrexImgs.Mixfile do
  use Mix.Project

  def project do
    [app: :librex_imgs,
     version: "1.0.2",
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
     {:earmark, "~> 1.2", only: :dev},
     {:ex_doc, "~> 0.16", only: :dev},
     {:excoveralls, "~> 0.6", only: [:dev, :test]}]
  end

  defp description do
    "Elixir library to convert office documents to other formats using LibreOffice. Now supports converting from images!"
  end

  defp package do
    [files: ["lib", "mix.exs", "README*", "LICENSE*"],
     contributors: ["Richard Nyström", "Sergey Chechaev", "Kwasi Y. Oppong-Badu"],
     maintainers: ["Kwasi Y. Oppong-Badu"],
     licenses: ["MIT"],
     links: %{"GitHub" => "https://github.com/kwayebopp/librex-imgs", "Docs" => "http://hexdocs.pm/librex"}]
  end
end
