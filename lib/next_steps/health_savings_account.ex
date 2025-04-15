defmodule NextSteps.HealthSavingsAccount do
  @moduledoc """
  Represents a Health Savings Account (HSA) for a user
  """

  use Ash.Resource,
    data_layer: AshPostgres.DataLayer,
    domain: NextSteps

  postgres do
    table("health_savings_accounts")
    repo(NextSteps.Repo)
  end

  attributes do
    uuid_v7_primary_key(:id)
    create_timestamp(:created_at)

    attribute(:balance, :decimal)
    attribute(:yearly_contribution, :decimal)
    attribute(:monthly_contribution, :decimal)
    attribute(:employer_match, :decimal)

    attribute(:employer_match_type, :atom) do
      constraints(one_of: [:percentage, :fixed_amount, :none])
    end

    attribute(:effective_on, :utc_datetime)
    attribute(:expired_at, :utc_datetime)
  end

  relationships do
    belongs_to :user, NextSteps.User do
      attribute_type(:uuid)
      allow_nil?(false)
    end
  end
end
