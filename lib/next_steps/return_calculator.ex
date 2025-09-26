defmodule ReturnCalculator do
  alias NextSteps.ReturnInput

  def calculate_return(
        # %{
        #   starting_amount: starting_amount,
        #   annual_contribution: annual_contribution,
        #   annual_rate_of_return: annual_rate_of_return,
        #   years: years
        # } = return_input_attrs
        # ) do
        return_input_attrs
      ) do
    case Ash.create(ReturnInput, return_input_attrs) do
      {:ok, changeset} ->
        do_calculate_return(changeset)

      {:error, changeset} ->
        changeset
    end
  end

  defp do_calculate_return(
         %{
           starting_amount: starting_amount,
           annual_contribution: annual_contribution,
           annual_rate_of_return: annual_rate_of_return,
           years: years
         } = _changeset
       ) do
    interest_rate = calculate_interest_rate(annual_rate_of_return, years)

    future_value =
      calculate_starting_amount_value(starting_amount, interest_rate) +
        calculate_annual_contribution_value(
          annual_contribution,
          interest_rate,
          annual_rate_of_return
        )

    Float.round(future_value, 0)
  end

  defp calculate_annual_contribution_value(
         annual_contribution,
         interest_rate,
         annual_rate_of_return
       ) do
    annual_contribution *
      ((interest_rate - 1) / Decimal.to_float(annual_rate_of_return))
  end

  defp calculate_interest_rate(annual_rate_of_return, years) do
    1
    |> Decimal.add(annual_rate_of_return)
    |> Decimal.to_float()
    |> :math.pow(years)
  end

  defp calculate_starting_amount_value(starting_amount, interest_rate) do
    starting_amount * interest_rate
  end
end
