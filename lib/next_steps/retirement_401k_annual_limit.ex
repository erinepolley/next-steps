defmodule NextSteps.Retirement401kAnnualLimit do
  @moduledoc """
  Represents annual contribution limits for 401(k) accounts, including individual, employer,
  and catch-up contribution limits for different tax filing statuses by year
  """

  use Ash.Resource,
    data_layer: AshPostgres.DataLayer,
    domain: NextSteps

  postgres do
    table("retirement_401k_annual_limits")
    repo(NextSteps.Repo)
  end

  attributes do
    uuid_v7_primary_key(:id)
    create_timestamp(:created_at)

    attribute(:year, :integer)
    attribute(:individual_limit, :decimal)
    attribute(:employer_limit, :decimal)
    attribute(:combined_limit, :decimal)
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
