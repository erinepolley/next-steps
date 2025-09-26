defmodule NextSteps.ReturnInput do
  @moduledoc """
  This is an ephemeral resource to validate the input for the investment return
  calculation widget.
  """
  use Ash.Resource,
    data_layer: Ash.DataLayer.Simple,
    domain: NextSteps

  alias NextSteps.Validations.GrowthRatePrecision

  attributes do
    attribute :starting_amount, :integer do
      allow_nil?(false)
    end

    attribute :annual_contribution, :integer do
      allow_nil?(false)
    end

    attribute :annual_rate_of_return, :decimal do
      allow_nil?(false)
    end

    attribute :years, :integer do
      allow_nil?(false)
    end
  end

  resource do
    require_primary_key?(false)
  end

  validations do
    validate(compare(:annual_contribution, greater_than_or_equal_to: 0))
    validate(compare(:annual_rate_of_return, greater_than_or_equal_to: 0))
    validate(compare(:starting_amount, greater_than_or_equal_to: 0))
    validate(compare(:years, greater_than_or_equal_to: 1))
    validate({GrowthRatePrecision, annual_rate_of_return: :annual_rate_of_return})
  end

  actions do
    default_accept([:annual_contribution, :annual_rate_of_return, :starting_amount, :years])

    create :create do
      primary?(true)
    end
  end
end
