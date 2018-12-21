defmodule Core.Repo.Migrations.CreateIdpsTable do
  use Ecto.Migration
  @timestamp_opts [type: :utc_datetime]

  def change do
    create table(:idps) do
      add :external_id, :uuid, null: false
      add :full_name, :string, null: false
      add :email, :string
      add :gender, :string
      add :birth_date, :date
      add :phone_number, :string
      add :phone_number_additional, :string
      add :additional_info, :string
      add :reference_number, :string
      add :migration_date, :date
      add :service_field, :string

      add :idp_status_id, references(:idp_statuses, on_delete: :nothing)
      add :created_by_id, references(:users, on_delete: :nothing)
      add :idp_category_id, references(:idp_categories, on_delete: :nothing)
      add :project_id, references(:projects, on_delete: :nothing)

      # Migration info
      add :from_state_id, references(:states, on_delete: :nothing)
      add :from_city_id, references(:cities, on_delete: :nothing)
      add :current_state_id, references(:states, on_delete: :nothing)
      add :current_city_id, references(:cities, on_delete: :nothing)

      timestamps()
    end

    create index(:idps, [:external_id])
    create index(:idps, [:reference_number])
    create index(:idps, [:full_name])
    create index(:idps, [:email])
    create index(:idps, [:phone_number])
    create index(:idps, [:phone_number_additional])
    create index(:idps, [:additional_info])
  end
end
