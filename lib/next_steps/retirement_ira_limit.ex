defmodule NextSteps.RetirementIraLimit do
  @moduledoc """
  Represents annual contribution limits for IRA accounts (both Traditional and Roth),
  including income caps and catch-up contribution limits by tax filing status and year
  """

  use Ash.Resource,
    data_layer: AshPostgres.DataLayer,
    domain: NextSteps

  postgres do
    table("retirement_ira_limits")
    repo(NextSteps.Repo)
  end

  attributes do
    uuid_v7_primary_key(:id)
    create_timestamp(:created_at)

    attribute(:year, :integer)

    attribute(:roth_type, :atom) do
      constraints(one_of: [:traditional, :roth])
    end

    attribute(:agi_income_cap, :decimal)
    attribute(:limit_amount, :decimal)
    attribute(:over_50_catchup, :decimal)
    attribute(:description, :string)
  end

  relationships do
    belongs_to :tax_filing_status, NextSteps.TaxFilingStatus do
      attribute_type(:uuid)
      allow_nil?(false)
    end
  end
end
