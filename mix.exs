defmodule SecureIdp.MixProject do
  use Mix.Project

  def project do
    [
      name: "Secure IDP",
      apps_path: "apps",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      version: "0.0.1",
      source_url: "https://github.com/lbrty/secure-idp-backend",
      docs: [source_ref: "HEAD", main: "main", assets: "docs", extras: ["docs/main.md"]],
      deps: deps()
    ]
  end

  # Dependencies listed here are available only for this
  # project and cannot be accessed from applications inside
  # the apps folder.
  #
  # Run "mix help deps" for examples and options.
  defp deps do
    [
    ]
  end
end
