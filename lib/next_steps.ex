defmodule NextSteps do
  @moduledoc """
  NextSteps domain for all the resources.
  """

  use Ash.Domain, extensions: [AshJsonApi.Domain]

  resources do
    resource(__MODULE__.User)
    resource(__MODULE__.BrokerageAccount)
    resource(__MODULE__.Dependent529)
    resource(__MODULE__.HealthSavingsAccount)
    resource(__MODULE__.Retirement401k)
    resource(__MODULE__.Retirement401kAnnualLimit)
    resource(__MODULE__.RetirementIraLimit)
    resource(__MODULE__.RetirementRothIra)
    resource(__MODULE__.TaxBracket)
    resource(__MODULE__.TaxDeduction)
    resource(__MODULE__.TaxFilingStatus)
  end
end
