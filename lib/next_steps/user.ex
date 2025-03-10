defmodule NextSteps.User do
  @moduledoc """
  TBD
  """

  use Ash.Resource,
    data_layer: AshPostgres.DataLayer,
    domain: NextSteps

  postgres do
    table("users")
    repo(NextSteps.Repo)
  end

  attributes do
    uuid_v7_primary_key(:id)
    create_timestamp(:created_at)
    update_timestamp(:updated_at)

    attribute(:first_name, :string)
    attribute(:date_of_birth, :date)
    attribute(:email, :string)
    attribute(:gross_income, :float)
    attribute(:is_robot, :boolean)
    attribute(:last_name, :string)
    attribute(:last_login_at, :utc_datetime)
    attribute(:target_retirement_age, :float)
  end

  relationships do
    belongs_to(:tax_filing_status, NextSteps.TaxFilingStatus) do
      attribute_type(:uuid)
    end

    has_many(:retirement_401ks, NextSteps.Retirement401k)
    has_many(:retirement_roth_iras, NextSteps.RetirementRothIra)
    has_many(:dependent_529s, NextSteps.Dependent529)
    has_many(:health_savings_accounts, NextSteps.HealthSavingsAccount)
    has_many(:brokerage_accounts, NextSteps.BrokerageAccount)
  end
end
