defmodule NextSteps.Retirement401k do
  @moduledoc """
  Represents a user's 401(k) retirement account information
  """

  use Ash.Resource,
    data_layer: AshPostgres.DataLayer,
    domain: NextSteps

  postgres do
    table("retirement_401ks")
    repo(NextSteps.Repo)
  end

  attributes do
    uuid_v7_primary_key(:id)
    create_timestamp(:created_at)

    attribute(:balance, :decimal)
    attribute(:monthly_contribution, :decimal)
    attribute(:employer_match, :decimal)

    attribute :employer_match_type, :atom do
      constraints(one_of: [:percentage, :fixed_amount, :none])
    end

    attribute(:yearly_total_contribution, :decimal)
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
