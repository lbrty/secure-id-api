defmodule Core.Repo.Migrations.CreateSupportsBeneficiaryAgesJoinTable do
  use Ecto.Migration

  def change do
    create table(:supports_beneficiary_ages) do
      add :support_id, references(Support, on_delete: :delete_all)
      add :beneficiary_age_id, references(BeneficiaryAge, on_delete: :delete_all)
    end

    create unique_index(:idps_tags, [:idp_id, :tag_id])
  end
end
