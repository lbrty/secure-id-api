defmodule Core.SupportBeneficiaryAge do
  use Core.Model
  alias Core.{BeneficiaryAge, Support}

  @primary_key false
  schema "supports_beneficiary_ages" do
    belongs_to(:support, Support)
    belongs_to(:beneficiary_age, BeneficiaryAge)
  end
end
