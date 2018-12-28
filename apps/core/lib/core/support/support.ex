defmodule Core.Support do
  use Core.Model

  alias Core.{
    Idp,
    User,
    BeneficiaryAge,
    SupportBeneficiaryAge,
    Sphere,
    SupportSphere
  }

  schema "supports" do
    # Can be one of `s` - Social, l - Judicial
    field(:type, :string)

    # Background/reason for support
    field(:reason, :string)

    # Status can be one of
    # done - Consulted/helped
    # call - Call back/respond
    # j_support - Need judicial support
    # s_support - Need social support
    # monitor - Needs further monitoring
    # i - Unknown
    field(:status, :string)

    # Who registered support request
    belongs_to(:consultant, User)

    # Original record of a person
    belongs_to(:idp, Idp)

    many_to_many(:spheres, Sphere, join_through: SupportSphere)
    many_to_many(:beneficiary_ages, BeneficiaryAge, join_through: SupportBeneficiaryAge)
  end
end
