defmodule Core.Repo.Migrations.CreateBeneficiaryAgesTable do
  use Ecto.Migration

  def change do
    create table(:beneficiary_ages) do
      add :title, :string

      timestamps()
    end

    create unique_index(:beneficiary_ages, [:title])
  end
end
