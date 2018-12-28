defmodule Core.Idp do
  @moduledoc false
  use Core.Model

  alias Core.{
    IdpStatus,
    User,
    IdpCategory,
    Project,
    State,
    City,
    State,
    City,
    Tag,
    IdpTag
  }

  schema "idps" do
    field(:external_id, Ecto.UUID, autogenerate: true)

    field(:full_name, :string)
    field(:email, :string)
    field(:gender, :string)
    field(:birth_date, :date)
    field(:phone_number, :string)
    field(:phone_number_additional, :string)
    field(:additional_info, :string)
    field(:reference_number, :string)
    field(:migration_date, :date)

    # Field to use in data migrations
    # it is the only purpose of field.
    field(:service_field, :string)

    belongs_to(:idp_status, IdpStatus)
    belongs_to(:created_by, User)
    belongs_to(:idp_category, IdpCategory)
    belongs_to(:project, Project)

    # Migration info
    belongs_to(:from_state, State)
    belongs_to(:from_city, City)
    belongs_to(:current_state, State)
    belongs_to(:current_city, City)

    many_to_many(:tags, Tag, join_through: IdpTag)

    timestamps()
  end
end
