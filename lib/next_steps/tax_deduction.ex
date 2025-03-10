defmodule NextSteps.TaxDeduction do
  @moduledoc """
  Represents standard and itemized tax deductions available for different
  tax filing statuses by year
  """

  use Ash.Resource,
    data_layer: AshPostgres.DataLayer,
    domain: NextSteps

  postgres do
    table("tax_deductions")
    repo(NextSteps.Repo)
  end

  attributes do
    uuid_v7_primary_key(:id)
    create_timestamp(:created_at)

    attribute(:year, :integer)
    attribute(:name, :string)
    attribute(:slug, :string)
    attribute(:amount, :decimal)
  end

  relationships do
    belongs_to :tax_filing_status, NextSteps.TaxFilingStatus do
      attribute_type(:uuid)
      allow_nil?(false)
    end
  end
end
