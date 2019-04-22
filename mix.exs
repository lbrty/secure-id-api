defmodule Idp.Umbrella.MixProject do
  use Mix.Project

  def project do
    [
      apps_path: "apps",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases()
    ]
  end

  defp deps do
    [
      {:credo, "~> 1.0.0", only: [:dev, :test], runtime: false},
      {:inch_ex, github: "rrrene/inch_ex", only: [:dev, :test]}
    ]
  end

  defp aliases do
    [
      lint: ["credo --strict", "inch"],
      fmt: ["format mix.exs \"apps/**/*/.{ex,exs}\""],
      "test.all": [
        "cmd --app idp --app idp_web mix test --color --trace"
      ],
      "test.web": [
        "cmd --app idp_web mix test --color --trace"
      ],
      "test.core": [
        "cmd --app idp mix test --color --trace"
      ]
    ]
  end
end
