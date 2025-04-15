defmodule NextSteps.TaxBracket do
  @moduledoc """
  Represents tax brackets for different income ranges and filing statuses by year
  """

  use Ash.Resource,
    data_layer: AshPostgres.DataLayer,
    domain: NextSteps

  postgres do
    table("tax_brackets")
    repo(NextSteps.Repo)
  end

  attributes do
    uuid_v7_primary_key(:id)
    create_timestamp(:created_at)

    attribute(:year, :integer)
    attribute(:minimum_limit, :decimal)
    attribute(:maximum_limit, :decimal)
  end

  relationships do
    belongs_to :tax_filing_status, NextSteps.TaxFilingStatus do
      attribute_type(:uuid)
      allow_nil?(false)
    end
  end
end
