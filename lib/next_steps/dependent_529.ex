defmodule NextSteps.Dependent529 do
  @moduledoc """
  Represents a 529 college savings plan for a user's dependent
  """

  use Ash.Resource,
    data_layer: AshPostgres.DataLayer,
    domain: NextSteps

  postgres do
    table("dependent_529s")
    repo(NextSteps.Repo)
  end

  attributes do
    uuid_v7_primary_key(:id)
    create_timestamp(:created_at)

    attribute(:balance, :decimal)
    attribute(:yearly_contribution, :decimal)
    attribute(:monthly_contribution, :decimal)
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
