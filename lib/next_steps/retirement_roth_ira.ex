defmodule NextSteps.RetirementRothIra do
  @moduledoc """
  Represents a user's Roth IRA retirement account information
  """

  use Ash.Resource,
    data_layer: AshPostgres.DataLayer,
    domain: NextSteps

  postgres do
    table("retirement_roth_iras")
    repo(NextSteps.Repo)
  end

  attributes do
    uuid_v7_primary_key(:id)
    create_timestamp(:created_at)

    attribute(:balance, :decimal)
    attribute(:monthly_contribution, :decimal)
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
