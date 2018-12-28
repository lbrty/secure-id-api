defmodule Core.BeneficiaryAge do
  use Core.Model

  schema "beneficiary_age" do
    field(:title, :string)

    timestamps()
  end
end
