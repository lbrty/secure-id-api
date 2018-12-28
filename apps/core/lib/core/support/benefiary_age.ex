defmodule Core.BeneficiaryAge do
  use Core.Model

  schema "beneficiary_ages" do
    field(:title, :string)

    timestamps()
  end
end
