defmodule NextSteps.TaxFilingStatus do
  @moduledoc """
  Reference table for tax filing statuses and their descriptions
  """

  use Ash.Resource,
    data_layer: AshPostgres.DataLayer,
    domain: NextSteps

  postgres do
    table("tax_filing_status")
    repo(NextSteps.Repo)
  end

  attributes do
    uuid_v7_primary_key(:id)

    attribute(:status, :atom) do
      constraints(
        one_of: [
          :single,
          :married_filing_jointly,
          :married_filing_separately,
          :head_of_household,
          :qualifying_widow_widower
        ]
      )
    end

    attribute(:description, :string)
  end
end
