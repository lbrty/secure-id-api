defmodule Core.Idp do
  @moduledoc false
  use Core.Schema

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

    belongs_to(:idp_status, Core.IdpStatus)
    belongs_to(:created_by, Core.User)
    belongs_to(:idp_category, Core.IdpCategory)
    belongs_to(:project, Core.Project)

    # Migration info
    belongs_to(:from_state, Core.State)
    belongs_to(:from_city, Core.City)
    belongs_to(:current_state, Core.State)
    belongs_to(:current_city, Core.City)

    many_to_many(:tags, Core.Tag, join_through: Core.IdpsTags)

    timestamps()
  end
end
