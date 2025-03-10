defmodule NextSteps.EmergencySaving do
  @moduledoc """
  Represents a user's emergency savings account
  """

  use Ash.Resource,
    data_layer: AshPostgres.DataLayer,
    domain: NextSteps

  postgres do
    table("emergency_savings")
    repo(NextSteps.Repo)
  end

  attributes do
    uuid_v7_primary_key(:id)
    create_timestamp(:created_at)

    attribute(:balance, :decimal)
    attribute(:account_number, :string)
    attribute(:account_nickname, :string)
    attribute(:effective_on, :utc_datetime)
  end

  relationships do
    belongs_to :user, NextSteps.User do
      attribute_type(:uuid)
      allow_nil?(false)
    end
  end
end
